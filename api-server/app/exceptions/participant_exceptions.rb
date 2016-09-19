
##
# Exception for when a match has less than 10 participants
##
class NotEqualTenParticipantsError < StandardError
	def initialize(match_id, num_participants)
		puts("Match " + match_id.to_s + " has " + num_participants.to_s + " participants." \
			 " A match must have exactly 10 participants")
	end
end

##
# Exception for when a match has less than 10 participant identities
##
class NotEqualTenParticipantIdsError < StandardError
	def initialize(match_id, num_participant_ids)
		puts("Match " + match_id.to_s + " has " + num_participant_ids.to_s + " participants ids." \
			 " A match must have exactly 10 participant ids")
	end
end

##
# Exception for when there is a mismatch between participant and participant identity
##
class ParticipantIdentityError < StandardError
	def initialize()
		puts("Participant does not match with participant identity")
	end
end