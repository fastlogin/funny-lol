
class SimpleMatchViewerController < ApplicationController

	BASE_CHAMP_ICO_URL = "http://ddragon.leagueoflegends.com/cdn/6.23.1/img/champion/"
	BASE_SSPELL_ICO_URL = "http://ddragon.leagueoflegends.com/cdn/6.23.1/img/spell/"
	BASE_ITEM_ICO_URL = "http://ddragon.leagueoflegends.com/cdn/6.23.1/img/item/"

	# GET /simple_match_viewer/matches/:ids
	def get_matches

		smv_matches = []
		matches = Match.find params[:ids].split(',')
		smv_match_list = matches.map do |match|

			participants = Participant.where(match_id: match.match_id)

			blue_participants = []

			purple_participants = []

			blue_won = false;

			participants.each do |participant|

				champion_static = StaticDatum.find_by data_type: "CHAMPION", object_id: participant.champion_id
				sspell_one_static = StaticDatum.find_by data_type: "SSPELL", object_id: participant.spell_one_id
				sspell_two_static = StaticDatum.find_by data_type: "SSPELL", object_id: participant.spell_two_id

				item_one_url = BASE_ITEM_ICO_URL + participant.item_one_id.to_s + ".png"
				item_two_url = BASE_ITEM_ICO_URL + participant.item_two_id.to_s + ".png"
				item_three_url = BASE_ITEM_ICO_URL + participant.item_three_id.to_s + ".png"
				item_four_url = BASE_ITEM_ICO_URL + participant.item_four_id.to_s + ".png"
				item_five_url = BASE_ITEM_ICO_URL + participant.item_five_id.to_s + ".png"
				item_six_url = BASE_ITEM_ICO_URL + participant.item_six_id.to_s + ".png"
				item_seven_url = BASE_ITEM_ICO_URL + participant.item_seven_id.to_s + ".png"

				if participant.item_one_id == 0
					item_one_url = "app/assets/images/misc/empty.png"
				elsif participant.item_one_id == 2043
					item_one_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				if participant.item_two_id == 0
					item_two_url = "app/assets/images/misc/empty.png"
				elsif participant.item_two_id == 2043
					item_two_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				if participant.item_three_id == 0
					item_three_url = "app/assets/images/misc/empty.png"
				elsif participant.item_three_id == 2043
					item_three_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				if participant.item_four_id == 0
					item_four_url = "app/assets/images/misc/empty.png"
				elsif participant.item_four_id == 2043
					item_four_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				if participant.item_five_id == 0
					item_five_url = "app/assets/images/misc/empty.png"
				elsif participant.item_five_id == 2043
					item_five_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				if participant.item_six_id == 0
					item_six_url = "app/assets/images/misc/empty.png"
				elsif participant.item_six_id == 2043
					item_six_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				if participant.item_seven_id == 0
					item_seven_url = "app/assets/images/misc/empty.png"
				elsif participant.item_seven_id == 2043
					item_seven_url = BASE_ITEM_ICO_URL + "2055.png"
				end

				participant_json = {
					:summonerId => participant.summoner_id,
					:championIcoUrl => BASE_CHAMP_ICO_URL + champion_static.url_key + ".png",
					:sspellOneIcoUrl => BASE_SSPELL_ICO_URL + sspell_one_static.url_key + ".png",
					:sspellTwoIcoUrl => BASE_SSPELL_ICO_URL + sspell_two_static.url_key + ".png",
					:tierIcoUrl => "app/assets/images/tier-icons/" + participant.highest_tier + ".png",
					:summonerName => participant.summoner_name,
					:itemOneIcoUrl => item_one_url,
					:itemTwoIcoUrl => item_two_url,
					:itemThreeIcoUrl => item_three_url,
					:itemFourIcoUrl => item_four_url,
					:itemFiveIcoUrl => item_five_url,
					:itemSixIcoUrl => item_six_url,
					:itemSevenIcoUrl => item_seven_url,
					:killCount => participant.kill_count,
					:deathCount => participant.death_count,
					:assistCount => participant.assist_count,
					:creepScore => participant.minions_killed,
					:goldEarned => participant.gold_earned,
				}

				if participant.team_id == 100
					blue_participants.push(participant_json) 
					blue_won = participant.winner;
				else
					purple_participants.push(participant_json)
				end

			end
  			smv_match_json = { 
  				:id => match.match_id, 
  				:duration => match.match_duration, 
  				:blueParticipants => blue_participants, 
  				:purpleParticipants => purple_participants, 
  				:blueWon => blue_won
  			}
  			smv_matches.push(smv_match_json)
		end
		render json: smv_matches
	end
end
