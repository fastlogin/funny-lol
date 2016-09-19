
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

	# Check if a match with match_id = match_json["matchId"] already exists in dafabase.
	def self.check_match_existence(match_json)
		Match.exists?(match_json["matchId"])
	end

	# Create a match from a match JSON and save it to database.
	def self.create_match(match_json)
	end
end
