
require 'statistics_exceptions'

##
# Champion Item Metric Object
#
# @author: George Ding (gd264@cornell.edu)
#
# @description: Object used to build statistics for item usage specific to champions.
# This will be one of the main objects used for data-mining and statistic building.
##
class ChampionItemMetric < ApplicationRecord

	##
	# Model methods and functions
	##

	# Check if item exists
	def self.check_item_validity(item_id)
		begin
			raise ItemNotExistError.new(item_id) if
				!StaticDatum.exists?(:data_type => "ITEM", :object_id => item_id)
		rescue ItemNotExistError => e
			logger.error e
			return true
		end
		return false
	end

	# Update statistic for champion-item usage
	def self.update_champion_item_stats(winner, champion_id, item_id)

		return if item_id == 0 # item id 0 means empty inventory slot so we don't care, skip

		# Validation
		begin
			raise ChampionNotExistError.new(champion_id) if
				!StaticDatum.exists?(:data_type => "CHAMPION", :object_id => champion_id)
		rescue ChampionNotExistError => e
			logger.error e
			return
		end
		return if ChampionItemMetric.check_item_validity(item_id)

		# Find the specific statistic for this champion, item
		@statistic_metric = ChampionItemMetric.find_by_champion_id_and_item_id(champion_id, item_id)
		@statistic_metric.increment(:num_games_picked, by = 1) # increment games picked
		@statistic_metric.increment(:num_games_won, by = 1) if winner # increment games won if they won

		@statistic_metric.save # save statistic
		@statistic_metric # return the statistic object
	end
end
