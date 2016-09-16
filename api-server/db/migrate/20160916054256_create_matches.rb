class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches, id: false do |t|
      t.primary_key :match_id

      t.integer :map_id
      t.string :region
      t.timestamp :match_date_time
      t.time :match_duration
      t.string :match_queue_type
      t.string :match_mode
      t.string :match_type
      t.string :season
      t.string :platform
      t.timestamps
    end
  end
end
