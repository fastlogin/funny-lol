class ChangeColNameForStatic < ActiveRecord::Migration[5.0]
  def change
  	rename_column :static_data, :type, :data_type
  end
end
