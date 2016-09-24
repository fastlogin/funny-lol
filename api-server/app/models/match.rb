
##
# Match Object
#
# @author: George Ding (gd264@cornell.edu)
#
# @description: Main object used to store all match data and provides data for classification.
# Matches are mined from Riot API using the Match Crawl Task.
##
class Match < ApplicationRecord

	##
	# Model properties
	##

	# Overwriting default primary key, match_id is external from Riot
	self.primary_key = "match_id"

	# Active Record associations
	has_many :participants
	has_many :match_event_champion_kills

	##
	# Model methods and functions
	##

	# Check if a match with match_id = match_json["matchId"] already exists in database.
	def self.check_match_existence(match_id)
		Match.exists?(match_id)
	end

	# Create a match from a match JSON and save it to database and return it.
	def self.create_match(match_json)

		return if !match_json["matchCreation"] # This can sometimes be empty somehow lol

		@match = Match.new(:match_id => match_json["matchId"])
		@match.map_id = match_json["mapId"]
		@match.region = match_json["region"]
		# Convert long to DateTime,(time since epoch milliseconds / 1000 = time since epoch seconds)
		@match.match_date_time = Time.at(match_json["matchCreation"]/1000)
		@match.match_duration = match_json["matchDuration"]
		@match.match_queue_type = match_json["queueType"]
		@match.match_mode = match_json["matchMode"]
		@match.match_type = match_json["matchType"]
		@match.season = match_json["season"]
		@match.platform = match_json["platformId"]
		@match.has_been_classified = false
		@match.is_funny = false

		@match.save # save
		@match # return record
	end
end
