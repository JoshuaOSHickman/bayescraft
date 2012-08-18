class AddCustomerIdToSubscriptions < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :customer_id, :string
  end
end
