class CreateChampionSummonerSpellMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :champion_summoner_spell_metrics do |t|
      t.integer :champion_id
      t.integer :summoner_spell_id
      t.integer :num_games_picked
      t.integer :num_games_won
      t.timestamps
    end
    add_index :champion_summoner_spell_metrics, [:champion_id, :summoner_spell_id], :unique => true
  end
end
