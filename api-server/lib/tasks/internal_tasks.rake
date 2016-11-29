
require 'rake'

##
# Tasks that deal with external interactions
##
namespace :funny_lol do

	##
	# Machine Learning Training (Means)
	#
	# @author: George Ding (gd264@cornell.edu)
	# @description: Train our temporary ML model by fitting the model with all of the
	# means.
	##
	desc "Training model... Fitting means..."
	task :train_means => [:environment] do

		features = ["attack_damage", "ability_power", "health", "mana", "armor", "magic_resist"]

		totals = Hash.new
		counts = Hash.new

		TempMachineLearningVariable.all.each do |variable|
			counts[variable.champion_id] = 0
			if !totals.key?(variable.champion_id)
				totals[variable.champion_id] = Hash.new
			end
			totals[variable.champion_id][variable.stat] = 0
		end

		Match.all.each do |match|

			participants = Participant.where(match_id: match.match_id)

			participants.each do |participant|

				eligible_participant = false
				items = [participant.item_one_id, participant.item_two_id, participant.item_three_id, participant.item_four_id, participant.item_five_id, participant.item_six_id]

				items.each do |item|
					if ItemStatistic.exists?(item)
						eligible_participant = true
						item_stats = ItemStatistic.find(item)
						item_stats.attributes.each_pair do |stat, value|
							if stat == "item_id" || stat == "created_at" || stat == "updated_at"
								next
							end
							totals[participant.champion_id][stat] += value
						end
					end
				end
				counts[participant.champion_id] += 1 if eligible_participant
			end
		end

		totals.each do |champion, stats|
			stats.each do |stat, value|
				variable = TempMachineLearningVariable.find_by(champion_id: champion, stat: stat)
				variable.mean = value.to_f / counts[champion]
				variable.save
			end
		end
	end

	##
	# Machine Learning Training (Variances)
	#
	# @author: George Ding (gd264@cornell.edu)
	# @description: Train our temporary ML model by fitting the model with all of the
	# variances.
	##
	desc "Training model... Fitting means..."
	task :train_variances => [:environment] do

		features = ["attack_damage", "ability_power", "health", "mana", "armor", "magic_resist"]

		mean_squared_errors = Hash.new
		means = Hash.new
		counts = Hash.new

		TempMachineLearningVariable.all.each do |variable|
			counts[variable.champion_id] = 0
			if !mean_squared_errors.key?(variable.champion_id)
				mean_squared_errors[variable.champion_id] = Hash.new
			end
			if !means.key?(variable.champion_id)
				means[variable.champion_id] = Hash.new
			end
			mean_squared_errors[variable.champion_id][variable.stat] = 0.0
			means[variable.champion_id][variable.stat] = variable.mean
		end

		Match.all.each do |match|

			participants = Participant.where(match_id: match.match_id)

			participants.each do |participant|

				final_build_stats = Hash.new
				eligible_participant = false
				items = [participant.item_one_id, participant.item_two_id, participant.item_three_id, participant.item_four_id, participant.item_five_id, participant.item_six_id]

				items.each do |item|
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

				if eligible_participant
					champion = participant.champion_id
					counts[champion] += 1
					final_build_stats.each do |stat, value|
						mean = means[champion][stat]
						mean_squared_errors[champion][stat] += (value.to_f - mean)**2
					end
				end
			end
		end

		mean_squared_errors.each do |champion, stats|
			stats.each do |stat, value|
				variable = TempMachineLearningVariable.find_by(champion_id: champion, stat: stat)
				variable.variance = value.to_f / counts[champion]
				variable.save
			end
		end
	end
end
