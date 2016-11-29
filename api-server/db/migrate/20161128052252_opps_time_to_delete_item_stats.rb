class OppsTimeToDeleteItemStats < ActiveRecord::Migration[5.0]
  def change
  	drop_table :item_stats
  end
end
