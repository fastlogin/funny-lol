class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.string :player1
      t.string :player2
      t.boolean :matchWon

      t.timestamps
    end
  end
end
