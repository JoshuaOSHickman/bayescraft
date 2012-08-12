class MakeBorkedDoOnTrialsNonNullable < ActiveRecord::Migration
  def up
  	Trial.update_all({:borked => false}, {:borked => nil})
  	change_column :trials, :borked, :boolean, :null => false, :default => false
  end

  def down
  	change_column :trials, :borked, :boolean
  end
end
