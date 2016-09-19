
require 'participant_exceptions'

##
# Participant Object
#
# @author: George Ding (gd264@cornell.edu)
#
# @description: Object used to represent a participant in a certain match. It is a summoner. Object
# also holds all of the stats associated with that summoner in that match. This includes things like
# KDA, gold information, item build, summoner spells, etc.
##
class Participant < ApplicationRecord

	##
	# Model properties
	##

	# Active Record associations
	belongs_to :match, dependent: :destroy

	##
	# Model methods and functions
	##

	# Check if number of participants for a match = 10
	def self.check_participant_num_validity(match_id, participants)
		begin
			num_participants = participants.length
			raise NotEqualTenParticipantsError.new(match_id, num_participants) if num_participants != 10
		rescue NotEqualTenParticipantsError => e
			logger.error e
		end
	end

	# Check if number of participant ids for a match = 10
	def self.check_participant_id_num_validity(match_id, participant_ids)
		begin
			num_participant_ids = participant_ids.length
			raise NotEqualTenParticipantIdsError.new(match_id, num_participant_ids) if num_participant_ids != 10
		rescue NotEqualTenParticipantIdsError => e
			logger.error e
		end
	end

	# Given a match record, create the 10 participants for it from the data found
	# in an entire match JSON.
	def self.create_participant(match, match_json)
		match_id = match.match_id
		participants = match_json["participants"]
		participant_identities = match_json["participantIdentities"]
		Participant.check_participant_num_validity(match_id, participants)
		Participant.check_participant_id_num_validity(match_id, participant_identities)
	end
end
