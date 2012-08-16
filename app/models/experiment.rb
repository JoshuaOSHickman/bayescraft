class Experiment < ActiveRecord::Base
  attr_accessible :action1, :action2, :name, :outcome, :user_id
  has_many :trials

  def status
  	trials1 = trials.select {|t| t.should_do_action1? && !t.borked? }
  	trials2 = trials.select {|t| t.should_do_action1 && !t.should_do_action1? && !t.borked } #set and false

  	return "More Data Needed" if trials1.size == 0 || trials2.size == 0

  	conversion1 = trials1.select {|t| t.outcome_good? }.size / trials1.size
  	conversion2 = trials2.select {|t| t.outcome_good? }.size / trials2.size

  	better = conversion1 > conversion2 ? action1 : action2

  	# adjust for doing the wrong thing
  	if better == action1
  		potential_wins = trials.select {|t| !t.should_do_action1? && (t.borked? || t.outcome_good?) } 
  		case2_trials = trials.select {|t| !should_do_action1? }
  		conversion2 = potential_wins.size / case2_trials.size
  	else
  		potential_wins = trials.select {|t| t.should_do_action1? && (t.borked? || t.outcome_good?) } 
  		case1_trials = trials.select {|t| should_do_action1? }
  		conversion2 = potential_wins.size / case1_trials.size
  	end
  	# If winner switches, we need more data
  	return "More Data Needed" if (conversion1 > conversion2 ? action1 : action2) != better

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
