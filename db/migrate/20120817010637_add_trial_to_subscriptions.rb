class AddTrialToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :trial, :boolean, :null => false, :default => false
  end
end
