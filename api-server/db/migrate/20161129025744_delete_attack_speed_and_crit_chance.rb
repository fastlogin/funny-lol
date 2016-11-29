class DeleteAttackSpeedAndCritChance < ActiveRecord::Migration[5.0]
  def change
  	remove_column :item_statistics, :attack_speed
  	remove_column :item_statistics, :critical_chance
  end
end
