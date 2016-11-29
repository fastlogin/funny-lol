class CreateFunnyMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :funny_matches do |t|
      t.integer :match_id
      t.integer :troll_participant_id
      t.timestamps
    end
  end
end
