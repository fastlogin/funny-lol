class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      add_foreign_key :articles, :authors
      t.belongs_to :match, index: true
      t.integer :summoner_id
      t.integer :match_id
      t.string :summoner_name
      t.integer :participant_id
      t.integer :profile_icon
      t.string :match_list_uri
      t.integer :champion_id
      t.string :highest_tier
      t.integer :spell_one_id
      t.integer :spell_two_id
      t.integer :team_id
      t.integer :item_one_id
      t.integer :item_two_id
      t.integer :item_three_id
      t.integer :item_four_id
      t.integer :item_five_id
      t.integer :item_six_id
      t.integer :item_seven_id
      t.integer :death_count
      t.integer :kill_count
      t.integer :assist_count
      t.integer :total_damage_dealt
      t.integer :total_damage_taken
      t.boolean :winner

      t.timestamps
    end
    add_foreign_key :participants, :matches, column: :match_id, primary_key: "match_id"
  end
end
