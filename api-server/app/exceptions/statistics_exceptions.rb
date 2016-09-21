
##
# Exception for when an item is not recognized
##
class ItemNotExistError < StandardError
	def initialize(item_id)
		puts("There exists no item with id: " + item_id.to_s)
	end
end

##
# Exception for when a champion is not recognized
##
class ChampionNotExistError < StandardError
	def initialize(champion_id)
		puts("There exists no champion with id: " + champion_id.to_s)
	end
end

##
# Exception for when a summoner spell is not recognized
##
class SSpellNotExistError < StandardError
	def initialize(sspell_id)
		puts("There exists no summoner spell with id: " + sspell_id.to_s)
	end
end
