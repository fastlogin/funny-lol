
class FunnyMatch < ApplicationRecord

	SSPELL_BAG_EPSILON = 0.0002
	ITEM_BAG_EPSILON = 0.0001
	ITEM_MULTI_VAR_GAUSSIAN_EPSILON = 0.00000000000001

	def self.classify_match(match_id)

		match = Match.find(match_id)
		match.has_been_classified = true
		participants = Participant.where(match_id: match.match_id)

		participants.each do |participant|
			if participant.calculate_sspell_p_value < SSPELL_BAG_EPSILON
				match.is_funny = true
				@funny_match = FunnyMatch.new(:match_id => match_id)
				@funny_match.troll_participant_id = participant.participant_id
				@funny_match.save
				next
			end
			if participant.calculate_build_p_value < ITEM_BAG_EPSILON
				match.is_funny = true
				@funny_match = FunnyMatch.new(:match_id => match_id)
				@funny_match.troll_participant_id = participant.participant_id
				@funny_match.save
				next
			end
			if participant.calculate_multi_var_gaussian_p_value < ITEM_MULTI_VAR_GAUSSIAN_EPSILON
				match.is_funny = true
				@funny_match = FunnyMatch.new(:match_id => match_id)
				@funny_match.troll_participant_id = participant.participant_id
				@funny_match.save
				next
			end
		end
		match.save
	end
end
