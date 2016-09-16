class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.belongs_to :match, index: true

      t.timestamps
    end
  end
end
