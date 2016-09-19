class CreateChampionItemMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :champion_item_metrics do |t|
      t.integer :champion_id
      t.integer :item_id
      t.integer :num_games_picked
      t.intger :num_games_won
      t.timestamps
    end
    add_index :champion_item_metrics, [:champion_id, :item_id], :unique => true
  end
end
