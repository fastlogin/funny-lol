class CreateTempMachineLearningVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_machine_learning_variables do |t|
      t.integer :champion_id
      t.string :stat
      t.decimal :mean, :precision => 12, :scale => 6
      t.decimal :variance, :precision => 12, :scale => 6
      t.timestamps
    end
  end
end
