
require 'rake'

##
# Match Crawl Task
#
# @author: George Ding (gd264@cornell.edu)
# @description: Main crawling task that crawls through Riot API, finds matches, saves them to
# database and also updates all statistics for champion item metrics and champion summoner spell
# metrics.
##

namespace :funny_lol do
	desc "Testing saving via crontab"
	task :match_crawl => [:environment] do

		require 'riot'

		num_players_game = STANDARD_TEAM_SIZE * STANDARD_TEAM_NUM
		num_players_featured_games = num_players_game * NUM_FEATURED_GAMES
		remaining_requests = TOTAL_REQUESTS - 1 - (2 * (NUM_FEATURED_GAMES * num_players_game))
		match_count = remaining_requests / num_players_featured_games

		featured_games = (RiotApi.get_featured_games)["gameList"]
		featured_games.each do |featured_game|
			featured_game["participants"].each do |participant|
				summoner_name = participant["summonerName"]
				summoner_name_minified = summoner_name.delete(" ").downcase
				summoner_id = RiotApi.get_summoner_by_name(summoner_name)[summoner_name_minified]["id"]
				match_list = RiotApi.get_match_list(summoner_id)["matches"]
				next if !match_list
				match_counter = 0
				match_list.each do |match|
					if match_counter >= match_count
						break
					end
					match_id = match["matchId"]
					if Match.check_match_existence(match_id)
						next
					end
					full_match = RiotApi.get_match(match_id)
					saved_match = Match.create_match(full_match)
					saved_participants = Participant.create_participants(saved_match, full_match)
					saved_participants.each do |saved_participant|
						winner = saved_participant.winner
						champion = saved_participant.champion_id
						items = saved_participant.get_items
						sspells = saved_participant.get_sspells
						items.each do |item|
							ChampionItemMetric.update_champion_item_stats(winner,champion,item)
						end
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
