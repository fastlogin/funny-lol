class ChangeTimeToSeconds < ActiveRecord::Migration[5.0]
  def change
  	change_column :matches, :match_duration, :integer
  end
end
