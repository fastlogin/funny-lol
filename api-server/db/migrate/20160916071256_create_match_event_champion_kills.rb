class CreateMatchEventChampionKills < ActiveRecord::Migration[5.0]
  def change
    create_table :match_event_champion_kills do |t|
      t.belongs_to :match, index: true

      t.timestamps
    end
  end
end
