class MakeShouldDoOnTrialsNonNullable < ActiveRecord::Migration
  def up
  	change_column :trials, :should_do_action1, :boolean, :null => false
  end

  def down
  	change_column :trials, :should_do_action1, :boolean
  end
end
