class CreateStaticData < ActiveRecord::Migration[5.0]
  def change
    create_table :static_data do |t|
      t.string :type
      t.integer :object_id
      t.string :name
      t.timestamps
    end
  end
end
