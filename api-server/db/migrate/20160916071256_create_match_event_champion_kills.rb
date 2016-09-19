class CreateMatchEventChampionKills < ActiveRecord::Migration[5.0]
  def change
    create_table :match_event_champion_kills do |t|
      t.belongs_to :match, index: true
      t.integer :match_id
      t.string :event_type
      t.timestamp :time_stamp
      t.integer :position_x
      t.integer :position_y
      t.integer :player_id
      t.integer :killer_id

      t.timestamps
    end
    add_foreign_key :match_event_champion_kills, :matches, column: :match_id, primary_key: "match_id"
  end
end
