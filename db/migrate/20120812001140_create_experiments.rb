class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :name
      t.string :action1
      t.string :action2
      t.string :outcome

      t.timestamps
    end
  end
end
