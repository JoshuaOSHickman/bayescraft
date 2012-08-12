class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :experiment_id
      t.boolean :should_do_action1
      t.boolean :outcome_good

      t.timestamps
    end
  end
end
