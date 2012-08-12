class ExperimentsController < ApplicationController
 	def index
		@experiments = Experiment.first(5)
  end

  def show
  	@experiment = Experiment.find(params[:id])
  	@trial = Trial.new do |t|
  		t.experiment_id = params[:id]
  		t.should_do_action1 = [true, false].sample
  	end
  	@trial.save! # use the id to provide link to edit page
  end

  def new
  end

  def create
  	@experiment = Experiment.new(params[:experiments])
  	if @experiment.save
  		redirect_to @experiment
  	else # validations fail 
  		redirect_to :home 
  	end
  end
end
