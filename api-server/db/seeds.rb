# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


# Initialize static data variables
champions = JSON.parse(File.open("db/static/champions.json").read)["data"]
items = JSON.parse(File.open("db/static/items.json").read)["data"]
sspells = JSON.parse(File.open("db/static/sspells.json").read)["data"]
maps = JSON.parse(File.open("db/static/maps.json").read)["data"]


##
# Seed the static data
##

##
# Champions
champions.each do |champion, data|
	StaticDatum.create({
		data_type: "CHAMPION", 
		object_id: data["id"], 
		name: data["name"] + ", " + data["title"],
		url_key: data["key"]
		})
end

##
# Items
items.each do |item, data|
	StaticDatum.create({
		data_type: "ITEM", 
		object_id: data["id"], 
		name: data["name"]
		})
end


##
# Summoner Spells
sspells.each do |sspell, data|
	StaticDatum.create({
		data_type: "SSPELL", 
		object_id: data["id"], 
		name: data["name"],
		url_key: data["key"]
		})
end

##
# Maps
maps.each do |map, data|
	StaticDatum.create({
		data_type: "MAP", 
		object_id: data["mapId"], 
		name: data["mapName"]
		})
end

##
# Seed statistics to 0 count in order to start data mining
##

# ##
# # Initialize all champion-item statistics to 0
# champions.each do |champion, data_champion|
# 	items.each do |item, data_item|
# 		ChampionItemMetric.create({
# 			champion_id: data_champion["id"],
# 			item_id: data_item["id"],
# 			num_games_picked: 0,
# 			num_games_won: 0
# 			})
# 	end
# end

# ##
# # Initialize all champion-summonerspell statistics to 0
# champions.each do |champion, data_champion|
# 	sspells.each do |sspell, data_sspell|
# 		ChampionSummonerSpellMetric.create({
# 			champion_id: data_champion["id"],
# 			summoner_spell_id: data_sspell["id"],
# 			num_games_picked: 0,
# 			num_games_won: 0
# 			})
# 	end
# end

# ##
# # Item Dependencies
# items.each do |item, data|
# 	recipe_list = data["from"]
# 	next if !recipe_list
# 	recipe_list.each do |item_id|
# 		ItemDependency.create({
# 			parent_item_id: data["id"],
# 			child_item_id: item_id.to_i
# 			})
# 	end
# end
