class ChangeAsCritDecimalPrecision < ActiveRecord::Migration[5.0]
  def change
  	change_column :item_stats, :attack_speed, :decimal, precision: 10, scale: 5
  	change_column :item_stats, :critical_chance, :decimal, precision: 10, scale: 5
  end
end
