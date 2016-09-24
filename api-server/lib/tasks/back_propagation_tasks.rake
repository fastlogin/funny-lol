
require 'rake'

##
# Tasks that deal with internal interactions
##
namespace :funny_lol do

	##
	# Item Back Propagation
	#
	# @author: George Ding (gd264@cornell.edu)
	# @description: Back populate item counts with item propagation
	# @execution_date: 9/24/2016
	##
	desc "Fixing item counts"
	task :item_back_propagation => [:environment] do

		# Require necessary classes
		require 'static_util'

		metrics_to_be_fixed = ChampionItemMetric.where("num_games_picked > ?", 0) 
		metrics_to_be_fixed.each do |metric|
			recipe_items = StaticUtil.item_propagation(metric.item_id)
			num_winner = metric.num_games_won
			num_loser = metric.num_games_picked - num_winner
			recipe_items.each do |recipe_item|
				(0..num_winner-1).each do |i|
					ChampionItemMetric.update_champion_item_stats(true,metric.champion_id,recipe_item)
				end
				(0..num_loser-1).each do |j|
					ChampionItemMetric.update_champion_item_stats(false,metric.champion_id,recipe_item)
				end
			end
		end
	end
end
