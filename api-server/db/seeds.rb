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
# champions.each do |champion, data|
# 	StaticDatum.create({
# 		data_type: "CHAMPION", 
# 		object_id: data["id"], 
# 		name: data["name"] + ", " + data["title"],
# 		url_key: data["key"]
# 		})
# end

# ##
# # Items
# items.each do |item, data|
# 	StaticDatum.create({
# 		data_type: "ITEM", 
# 		object_id: data["id"], 
# 		name: data["name"]
# 		})
# end


# ##
# # Summoner Spells
# sspells.each do |sspell, data|
# 	StaticDatum.create({
# 		data_type: "SSPELL", 
# 		object_id: data["id"], 
# 		name: data["name"],
# 		url_key: data["key"]
# 		})
# end

# ##
# # Maps
# maps.each do |map, data|
# 	StaticDatum.create({
# 		data_type: "MAP", 
# 		object_id: data["mapId"], 
# 		name: data["mapName"]
# 		})
# end

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

##
# Item Dependencies
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

# ##
# # Item Stats
# items.each do |item, data|
# 	if data["consumed"] || data["consumeOnFull"]
# 		next
# 	end
# 	item_stats = {
# 		"FlatArmorMod" => 0,
#       	"FlatAttackSpeedMod" => 0,
#       	"FlatCritChanceMod" => 0,
#       	"FlatHPPoolMod" => 0,
#       	"FlatMPPoolMod" => 0,
#       	"FlatMagicDamageMod" => 0,
#       	"FlatPhysicalDamageMod" => 0,
#       	"FlatSpellBlockMod" => 0
# 	}
# 	data["stats"].each do |stat, value|
# 		item_stats[stat] = value
# 	end
# 	ItemStatistic.create({
# 		item_id: data["id"],
#       	attack_damage: item_stats["FlatPhysicalDamageMod"],
#       	ability_power: item_stats["FlatMagicDamageMod"],
#       	attack_speed: item_stats["FlatAttackSpeedMod"],
#       	critical_chance: item_stats["FlatCritChanceMod"],
#       	health: item_stats["FlatHPPoolMod"],
#       	mana: item_stats["FlatMPPoolMod"],
#       	armor: item_stats["FlatArmorMod"],
#       	magic_resist: item_stats["FlatSpellBlockMod"]
# 		})
# end

##
# Machine Learning Variables
champions.each do |champion, data|
	features = ["attack_damage", "ability_power", "health", "mana", "armor", "magic_resist"]
	features.each do |feature|
		TempMachineLearningVariable.create({
			champion_id: data["id"],
      		stat: feature,
      		mean: 0.00,
      		variance: 0.00,
			})
	end
end
