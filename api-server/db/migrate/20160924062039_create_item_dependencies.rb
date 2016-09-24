class CreateItemDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :item_dependencies do |t|
      t.integer :parent_item_id
      t.integer :child_item_id
      t.timestamps
    end
  end
end
