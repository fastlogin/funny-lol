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
      ##
      # Classification booleans, marks if a match has been
      # classified/looked at yet and if a match was classified
      # as troll.
      t.boolean :has_been_classified # marks if a match has been looked at
      t.boolean :is_funny # marks if match is troll/funny
      t.timestamps
    end
  end
end
