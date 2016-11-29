class UpdateMatchIdIntegerSize < ActiveRecord::Migration[5.0]
  def change
  	change_column :funny_matches, :match_id, :integer, limit: 8
  end
end
