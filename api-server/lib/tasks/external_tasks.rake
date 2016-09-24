
require 'rake'

##
# Tasks that deal with external interactions
##
namespace :funny_lol do

	##
	# Match Crawl Task
	#
	# @author: George Ding (gd264@cornell.edu)
	# @description: Main crawling task that crawls through Riot API, finds matches, saves them to
	# database and also updates all statistics for champion item metrics and champion summoner spell
	# metrics.
	##
	desc "Crawling for matches..."
	task :match_crawl => [:environment] do

		# Require necessary classes
		require 'riot'
		require 'static_util'

		# Initialize constants for match count, number of requests to get matches
		num_players_game = STANDARD_TEAM_SIZE * STANDARD_TEAM_NUM
		num_players_featured_games = num_players_game * NUM_FEATURED_GAMES
		remaining_requests = TOTAL_REQUESTS - 1 - (2 * (NUM_FEATURED_GAMES * num_players_game))
		match_count = remaining_requests / num_players_featured_games

		# Get featured games
		featured_games = RiotApi.get_featured_games
		return if featured_games == -1 # Return if non 200 response
		featured_games_list = featured_games["gameList"]

		featured_games_list.each do |featured_game|
			featured_game["participants"].each do |participant|

				summoner_name = participant["summonerName"]
				summoner_name_minified = summoner_name.delete(" ").downcase

				summoner = RiotApi.get_summoner_by_name(summoner_name)
				next if summoner == -1 # Skip if non 200 response

				summoner_id = -1
				if !summoner[summoner_name] && !summoner[summoner_name_minified]
					next
				elsif !summoner[summoner_name]
					summoner_id = summoner_id = summoner[summoner_name_minified]["id"]
				else
					summoner_id = summoner[summoner_name]["id"]
				end
				
				match_list_summoner = RiotApi.get_match_list(summoner_id)
				next if match_list_summoner == -1 # Skip if non 200 response
				match_list = match_list_summoner["matches"]
				next if !match_list # Skip summoner has no match history

				match_counter = 0
				match_list.each do |match|

					if match_counter >= match_count
						break
					end
					
					match_id = match["matchId"]
					next if Match.check_match_existence(match_id) # Skip if we have seen this match before

					full_match = RiotApi.get_match(match_id)
					next if full_match == -1
					saved_match = Match.create_match(full_match)
					saved_participants = Participant.create_participants(saved_match, full_match)
					saved_participants.each do |saved_participant|

						# Get data, initialize constants to update statistics
						winner = saved_participant.winner
						champion = saved_participant.champion_id
						items = saved_participant.get_items
						sspells = saved_participant.get_sspells

						# Update item metrics
						items.each do |item|
							# Get recipe items to update as well
							back_prop_items = StaticUtil.item_propagation(item)
							back_prop_items.each do |recipe_item|
								ChampionItemMetric.update_champion_item_stats(winner,champion,recipe_item)
							end

							ChampionItemMetric.update_champion_item_stats(winner,champion,item)
						end

						# Update summoner spell metrics
						sspells.each do |sspell|
							ChampionSummonerSpellMetric.update_champion_sspell_stats(winner,champion,sspell)
						end
					end
					match_counter += 1
				end
			end
		end
	end
end
