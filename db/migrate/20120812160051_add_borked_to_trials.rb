class AddBorkedToTrials < ActiveRecord::Migration
  def change
    add_column :trials, :borked, :boolean
  end
end
