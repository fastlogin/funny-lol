class MatchEventChampionKill < ApplicationRecord
	belongs_to :match, dependent: :destroy,
end
