
require 'participant_exceptions'

##
# Participant Object
#
# @author: George Ding (gd264@cornell.edu)
#
# @description: Object used to represent a participant in a certain match. It is a summoner. Object
# also holds all of the stats associated with that summoner in that match. This includes things like
# KDA, gold information, item build, summoner spells, etc.
##
class Participant < ApplicationRecord

	##
	# Model properties
	##

	# Active Record associations
	belongs_to :match, dependent: :destroy

	##
	# Model methods and functions
	##

	# Check if number of participants for a match = 10
	def self.check_participant_num_validity(match_id, participants)
		begin
			num_participants = participants.length
			raise NotEqualTenParticipantsError.new(match_id, num_participants) if num_participants != 10
		rescue NotEqualTenParticipantsError => e
			logger.error e
			return true
		end
		return false
	end

	# Check if number of participant ids for a match = 10
	def self.check_participant_id_num_validity(match_id, participant_ids)
		begin
			num_participant_ids = participant_ids.length
			raise NotEqualTenParticipantIdsError.new(match_id, num_participant_ids) if num_participant_ids != 10
		rescue NotEqualTenParticipantIdsError => e
			logger.error e
			return true
		end
		return false
	end

	# Given a match record, create the 10 participants for it from the data found
	# in an entire match JSON.
	def self.create_participants(match, match_json)

		# Initialize variables
		match_id = match.match_id
		participants = match_json["participants"]
		participant_identities = match_json["participantIdentities"]

		# Validation
		return if Participant.check_participant_num_validity(match_id, participants)
		return if Participant.check_participant_id_num_validity(match_id, participant_identities)

		# Sort so we can match up participants to participant identities to build the participant record
		p_sorted = participants.sort_by { |k| k["participantId"] }
		p_id_sorted = participant_identities.sort_by { |k| k["participantId"] }

		created_participants = []
		(0..p_sorted.length-1).each do |i|
			participant = p_sorted[i]
			participant_identity = p_id_sorted[i]
			participant_stats = participant["stats"]
			player_info = participant_identity["player"]

			# Validate mismatches between participants and participant identities
			begin
				raise ParticipantIdentityError.new if participant["participantId"] != participant_identity["participantId"]
			rescue ParticipantIdentityError => e
				logger.warn e
				next
			end

			@curr_participant = Participant.new
			@curr_participant.match_id = match_id
			@curr_participant.summoner_id = player_info["summonerId"]
			@curr_participant.summoner_name = player_info["summonerName"]
			@curr_participant.participant_id = participant["participantId"]
			@curr_participant.profile_icon = player_info["profileIcon"]
			@curr_participant.match_list_uri = player_info["matchHistoryUri"]
			@curr_participant.highest_tier = participant["highestAchievedSeasonTier"]
			@curr_participant.champion_id = participant["championId"]
			@curr_participant.spell_one_id = participant["spell1Id"]
			@curr_participant.spell_two_id = participant["spell2Id"]
			@curr_participant.item_one_id = participant_stats["item0"]
			@curr_participant.item_two_id = participant_stats["item1"]
			@curr_participant.item_three_id = participant_stats["item2"]
			@curr_participant.item_four_id = participant_stats["item3"]
			@curr_participant.item_five_id = participant_stats["item4"]
			@curr_participant.item_six_id = participant_stats["item5"]
			@curr_participant.item_seven_id = participant_stats["item6"]
			@curr_participant.death_count = participant_stats["deaths"]
			@curr_participant.kill_count = participant_stats["kills"]
			@curr_participant.assist_count = participant_stats["assists"]
			@curr_participant.total_damage_dealt = participant_stats["totalDamageDealtToChampions"]
			@curr_participant.total_damage_taken = participant_stats["totalDamageTaken"]
			@curr_participant.winner = participant_stats["winner"]
			@curr_participant.team_id = participant["teamId"]
			@curr_participant.gold_earned = participant_stats["goldEarned"]
			@curr_participant.minions_killed = participant_stats["minionsKilled"]

			@curr_participant.save # save
			created_participants.push(@curr_participant) # append to returned collection
		end
		created_participants # return record collection
	end

	def get_items
		[item_one_id, item_two_id, item_three_id, item_four_id, item_five_id, item_six_id, item_seven_id]
	end

	def get_items_no_trinket
		[item_one_id, item_two_id, item_three_id, item_four_id, item_five_id, item_six_id]
	end

	def get_sspells
		[spell_one_id, spell_two_id]
	end

	##
	# Bag of Marbles Probabilities
	##
	def calculate_sspell_p_value

		total = 0
		sspell_one_count = 0
 		sspell_two_count = 0

		all_sspell_metrics = ChampionSummonerSpellMetric.where(champion_id: champion_id)

		all_sspell_metrics.each do |sspell_metric|
			sspell_one_count = sspell_metric.num_games_picked if sspell_metric.summoner_spell_id == spell_one_id
			sspell_two_count = sspell_metric.num_games_picked if sspell_metric.summoner_spell_id == spell_two_id
			total += sspell_metric.num_games_picked
		end

		sspell_one_probability = sspell_one_count.to_f / total
		sspell_two_probability = sspell_two_count.to_f / total

		sspell_one_probability * sspell_two_probability
	end

	def calculate_build_p_value

		total = 0
		item_counts = Hash.new
		item_count = 0
		get_items_no_trinket.each do |item|
			next if item == 0
			item_count += 1
			item_counts[item] = 0
		end

		all_item_metrics = ChampionItemMetric.where(champion_id: champion_id)

		all_item_metrics.each do |item_metric|
			item_counts.each do |item, count|
				item_counts[item] = item_metric.num_games_picked if item_metric.item_id == item
			end
			total += item_metric.num_games_picked
		end

		total_probability = 0
		get_items_no_trinket.each do |item|
			total_probability += (item_counts[item].to_f / total)
		end
		total_probability / item_count.to_f
	end

	##
	# Temporary Machine Learning Multivariate Gaussian Probability
	##
	def calculate_multi_var_gaussian_p_value

		features = ["attack_damage", "ability_power", "health", "mana", "armor", "magic_resist"]

		final_build_stats = Hash.new

		get_items_no_trinket.each do |item|
			if ItemStatistic.exists?(item)
				eligible_participant = true
				item_stats = ItemStatistic.find(item)
				item_stats.attributes.each_pair do |stat, value|
					if stat == "item_id" || stat == "created_at" || stat == "updated_at"
						next
					end
					final_build_stats[stat] = 0 if !final_build_stats.key?(stat)
					final_build_stats[stat] += value
				end
			end
		end

		total_probability = 1.0

		final_build_stats.each do |stat, value|

			gaussian_variable = TempMachineLearningVariable.find_by(champion_id: champion_id, stat: stat)

			two_pi_std_sqrt = Math.sqrt(2 * Math::PI * Math.sqrt(gaussian_variable.variance))
			mean_squared_error = (value.to_f - gaussian_variable.mean)**2.to_f
			two_times_variance = 2.to_f * gaussian_variable.variance
			exp_factor = (mean_squared_error * -1) / two_times_variance
			gaussian_probability = (1 / two_pi_std_sqrt) * Math.exp(exp_factor)

			total_probability *= gaussian_probability
		end
		total_probability
	end
end
