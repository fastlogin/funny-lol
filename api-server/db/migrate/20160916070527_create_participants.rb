class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      add_foreign_key :articles, :authors
      t.belongs_to :match, index: true

      ##
      # Summoner information/identity
      t.integer :summoner_id
      t.string :summoner_name
      t.integer :participant_id
      t.integer :profile_icon
      t.string :match_list_uri
      t.string :highest_tier
      ##
      # Match information
      t.integer :match_id
      t.integer :champion_id
      ##
      # Summoner spells
      t.integer :spell_one_id
      t.integer :spell_two_id
      ##
      # Inventory, item build
      t.integer :item_one_id
      t.integer :item_two_id
      t.integer :item_three_id
      t.integer :item_four_id
      t.integer :item_five_id
      t.integer :item_six_id
      t.integer :item_seven_id
      ##
      # KDA information
      t.integer :death_count
      t.integer :kill_count
      t.integer :assist_count
      ##
      # Damage information
      t.integer :total_damage_dealt
      t.integer :total_damage_taken
      ##
      # Team information
      t.boolean :winner
      t.integer :team_id
      ##
      # Gold information
      t.integer :gold_earned
      t.integer :minions_killed

      t.timestamps
    end
    add_foreign_key :participants, :matches, column: :match_id, primary_key: "match_id"
  end
end
