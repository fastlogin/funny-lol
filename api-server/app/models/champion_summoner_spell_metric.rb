
require 'statistics_exceptions'

##
# Champion Summoner Spell Metric Object
#
# @author: George Ding (gd264@cornell.edu)
#
# @description: Object used to build statistics for summoner spell usage specific to champions.
# This will be one of the main objects used for data-mining and statistic building.
##
class ChampionSummonerSpellMetric < ApplicationRecord

	##
	# Model methods and functions
	##

	# Check if summoner spell exists
	def self.check_sspell_validity(sspell_id)
		begin
			raise SSpellNotExistError.new(sspell_id) if
				!StaticDatum.exists?(:data_type => "SSPELL", :object_id => sspell_id)
		rescue SSpellNotExistError => e
			logger.error e
			return true
		end
		return false
	end

	# Update statistic for champion-summonerspell usage
	def self.update_champion_sspell_stats(winner, champion_id, sspell_id)

		# Validation
		begin
			raise ChampionNotExistError.new(champion_id) if
				!StaticDatum.exists?(:data_type => "CHAMPION", :object_id => champion_id)
		rescue ChampionNotExistError => e
			logger.error e
			return
		end
		return if ChampionSummonerSpellMetric.check_sspell_validity(sspell_id)

		# Find the specific statistic for this champion, summoner spell
		@statistic_metric =
			ChampionSummonerSpellMetric.find_by_champion_id_and_summoner_spell_id(champion_id, sspell_id)
		@statistic_metric.increment(:num_games_picked, by = 1) # increment games picked
		@statistic_metric.increment(:num_games_won, by = 1) if winner # increment games won if they won

		@statistic_metric.save # save statistic
		@statistic_metric # return the statistic object
	end
end
