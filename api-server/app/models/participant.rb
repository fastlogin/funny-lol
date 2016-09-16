class Participant < ApplicationRecord
	belongs_to :match, dependent: :destroy,
end
