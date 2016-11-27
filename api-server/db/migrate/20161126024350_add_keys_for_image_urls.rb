class AddKeysForImageUrls < ActiveRecord::Migration[5.0]
  def change
  	add_column :static_data, :url_key, :string
  end
end
