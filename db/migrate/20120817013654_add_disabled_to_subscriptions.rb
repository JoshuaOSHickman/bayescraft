class AddDisabledToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :disabled, :boolean, :null => false, :default => false
  end
end
