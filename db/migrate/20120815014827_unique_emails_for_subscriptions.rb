class UniqueEmailsForSubscriptions < ActiveRecord::Migration
  def change
  	add_index :subscriptions, :email, :unique => true
  end
end
