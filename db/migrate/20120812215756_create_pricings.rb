class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|

      t.timestamps
    end
  end
end
