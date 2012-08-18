class Experiment < ActiveRecord::Base
  attr_accessible :action1, :action2, :name, :outcome, :user_id
  has_many :trials

  def new_trial
    Trial.new do |t|
      t.experiment_id = id
      t.should_do_action1 = [true, false].sample
      t.save!
    end
  end

  def status
  	trials1 = trials.select {|t| t.should_do_action1? && !t.borked? }
  	trials2 = trials.select {|t| !t.should_do_action1? && !t.borked? }

  	return "More Data Needed" if trials1.size == 0 || trials2.size == 0

  	conversion1 = trials1.select {|t| t.outcome_good? }.size.to_f / trials1.size.to_f
  	conversion2 = trials2.select {|t| t.outcome_good? }.size.to_f / trials2.size.to_f

  	better = conversion1 > conversion2 ? action1 : action2

  	# adjust for doing the wrong thing
    # means bump up the worse one to it's potential if those trials weren't borked
  	if better == action1
      case2_trials = trials.select {|t| !should_do_action1? }
  		potential_wins2 = case2_trials.select {|t| t.borked? || t.outcome_good? } 
  		conversion2 = potential_wins2.size.to_f / case2_trials.size.to_f
  	else
      case1_trials = trials.select {|t| t.should_do_action1? }
  		potential_wins1 = case1_trials.select {|t| t.borked? || t.outcome_good? } 
  		conversion1 = potential_wins1.size / case1_trials.size
  	end
  	# If winner switches, we need more data
  	return "More Data Needed" if (conversion1 > conversion2 ? action1 : action2) != better

    return "No successful trials yet" if conversion2 + conversion1 == 0

		znumerator = conversion1 - conversion2
		frac1 = conversion1 * (1 - conversion1) / trials1.size
		frac2 = conversion2 * (1 - conversion2) / trials2.size
  
  	zscore = (znumerator / Math.sqrt(frac2 + frac1)).abs
    return "Results are in: #{better} is significantly better" if zscore >= 2.33
    return "There's a preference for #{better} but we aren't sure yet" if zscore >= 1.65
    return "Doesn't have a large enough difference to notice" if trials.size > 35
		return "More Data Needed"
  end
end
