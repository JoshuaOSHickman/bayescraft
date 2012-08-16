class AddUserIdToExperiment < ActiveRecord::Migration
  def change
  	add_column :experiments, :user_id, :int
  end
end
