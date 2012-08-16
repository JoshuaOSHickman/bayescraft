class RemovePricingsModel < ActiveRecord::Migration
  def change
  	drop_table :pricings
  end
end
