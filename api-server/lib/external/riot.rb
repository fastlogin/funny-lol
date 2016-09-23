
require "http"
require "json"

##
# Riot API
#
# @author: George Ding (gd264)
# @description: Ruby object to interface with and interact with the Riot API. This object was made
# to abstract out API calls for ease of use. Also allows for easy modular implementation for any
# part of the code that may need to make requests to the Riot API.
##
class RiotApi

	##
	# Static final variables for Riot API
	BASE_URL = "https://global.api.pvp.net/api/lol"
	BASE_URL_V2 = "https://na.api.pvp.net/api/lol/na"
	BASE_URL_V3 = "https://na.api.pvp.net/observer-mode/rest" # Currently only used for featured games
	API_KEY_EXT = "api_key=" + RIOT_KEY
	CURRENT_RANKED_QUEUES = ["TEAM_BUILDER_DRAFT_RANKED_5x5", "RANKED_TEAM_5x5"]
	CURRENT_SEASONS = ["SEASON2016"]

	##
	# Endpoint versions, will update as Riot API updates
	SUMMONER_VERSION = "1.4"
	MATCH_LIST_VERSION = "2.2"
	MATCH_VERSION = "2.2"

	# Append v to endpoint version
	def self.get_v(end_point)
		"v" + end_point
	end

	# Join all of the current ranked queues for use in url parameter
	def self.list_queues
		CURRENT_RANKED_QUEUES.join(",")
	end

	# Join all of the current seasons for use in url paramter
	def self.list_seasons
		CURRENT_SEASONS.join(",")
	end

	# (GET) featured-games-v1.0
	def self.get_featured_matches

		# Initialize url parameters and build url for request
		base = BASE_URL_V3
		api_key = API_KEY_EXT 
		url = "#{base}/featured/?#{api_key}"

		# Send request
		JSON.parse(HTTP.get(url))
	end

	# (GET) summoner-v1.4
	def self.get_summoner_by_name(summoner_name)

		# Initialize url parameters and build url for request
		base = BASE_URL_V2
		version = RiotApi.get_v(SUMMONER_VERSION)
		api_key = API_KEY_EXT
		url = "#{base}/#{version}/summoner/by-name/#{summoner_name}?#{api_key}"

		# Send request
		JSON.parse(HTTP.get(url))
	end

	# (GET) matchlist-v2.2
	def self.get_match_list(summoner_id)

		# Initialize url parameters and build url for request
		base = BASE_URL_V2
		version = RiotApi.get_v(MATCH_LIST_VERSION)
		id = summoner_id.to_s
		queues = RiotApi.list_queues
		seasons = RiotApi.list_seasons
		api_key = API_KEY_EXT
		url = "#{base}/#{version}/matchlist/by-summoner/#{id}?rankedQueues=#{queues}&#{seasons}&#{api_key}"

		# Send request
		JSON.parse(HTTP.get(url))
	end

	# (GET) match-v2.2
	def self.get_match(match_id)

		# Initialize url parameters and build url for request
		base = BASE_URL_V2
		version = RiotApi.get_v(MATCH_VERSION)
		id = match_id.to_s
		api = API_KEY_EXT
		url = "#{base}/#{version}/match/#{id}?includeTimeline=true&#{api}"

		# Send request
		JSON.parse(HTTP.get(url))
	end
end
