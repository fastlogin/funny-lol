class Match < ApplicationRecord
	self.primary_key = "match_id"

	has_many :participants
	has_many :match_event_champion_kills
end
