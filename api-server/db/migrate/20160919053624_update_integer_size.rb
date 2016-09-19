class UpdateIntegerSize < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :participants, :matches
  	remove_foreign_key :match_event_champion_kills, :matches
  	change_column :matches, :match_id, :integer, limit: 8
  	change_column :participants, :match_id, :integer, limit: 8
  	change_column :match_event_champion_kills, :match_id, :integer, limit: 8
  	add_foreign_key :participants, :matches, column: :match_id, primary_key: "match_id"
  	add_foreign_key :match_event_champion_kills, :matches, column: :match_id, primary_key: "match_id"
  end
end
