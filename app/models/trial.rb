class Trial < ActiveRecord::Base
  attr_accessible :experiment_id, :outcome_good, :should_do_action1
  belongs_to :experiment

  def complete?
  	borked? || !outcome_good.nil?
  end

  def outcome
  	@outcome ||= experiment.outcome
  end
end
