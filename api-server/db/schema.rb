# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160919053624) do

  create_table "champion_item_metrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "champion_id"
    t.integer  "item_id"
    t.integer  "num_games_picked"
    t.integer  "num_games_won"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["champion_id", "item_id"], name: "champion_to_item", unique: true, using: :btree
  end

  create_table "champion_summoner_spell_metrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "champion_id"
    t.integer  "summoner_spell_id"
    t.integer  "num_games_picked"
    t.integer  "num_games_won"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["champion_id", "summoner_spell_id"], name: "champion_to_sspell", unique: true, using: :btree
  end

  create_table "match_event_champion_kills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "match_id"
    t.string   "event_type"
    t.datetime "time_stamp"
    t.integer  "position_x"
    t.integer  "position_y"
    t.integer  "player_id"
    t.integer  "killer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_event_champion_kills_on_match_id", using: :btree
  end

  create_table "matches", primary_key: "match_id", id: :bigint, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "map_id"
    t.string   "region"
    t.datetime "match_date_time"
    t.time     "match_duration"
    t.string   "match_queue_type"
    t.string   "match_mode"
    t.string   "match_type"
    t.string   "season"
    t.string   "platform"
    t.boolean  "has_been_classified"
    t.boolean  "is_funny"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint   "match_id"
    t.integer  "summoner_id"
    t.string   "summoner_name"
    t.integer  "participant_id"
    t.integer  "profile_icon"
    t.string   "match_list_uri"
    t.string   "highest_tier"
    t.integer  "champion_id"
    t.integer  "spell_one_id"
    t.integer  "spell_two_id"
    t.integer  "item_one_id"
    t.integer  "item_two_id"
    t.integer  "item_three_id"
    t.integer  "item_four_id"
    t.integer  "item_five_id"
    t.integer  "item_six_id"
    t.integer  "item_seven_id"
    t.integer  "death_count"
    t.integer  "kill_count"
    t.integer  "assist_count"
    t.integer  "total_damage_dealt"
    t.integer  "total_damage_taken"
    t.boolean  "winner"
    t.integer  "team_id"
    t.integer  "gold_earned"
    t.integer  "minions_killed"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["match_id"], name: "index_participants_on_match_id", using: :btree
  end

  add_foreign_key "match_event_champion_kills", "matches", primary_key: "match_id"
  add_foreign_key "participants", "matches", primary_key: "match_id"
end
