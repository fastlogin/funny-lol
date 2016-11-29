class CreateItemStats < ActiveRecord::Migration[5.0]
  def change
    create_table :item_stats do |t|
      t.integer :item_id
      t.integer :attack_damage
      t.integer :ability_power
      t.decimal :attack_speed
      t.decimal :critical_chance
      t.integer :health
      t.integer :mana
      t.integer :armor
      t.integer :magic_resist
      t.timestamps
    end
  end
end
