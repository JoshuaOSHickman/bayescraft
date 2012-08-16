class ExperimentsController < ApplicationController
 	def index
		@experiments = Experiment.first(5)
  end

  def show
  	@experiment = Experiment.find(params[:id])
    redirect_to login_url unless @experiment.user_id.nil? || current_user.id == @experiment.user_id
  	@trial = (!@experiment.user_id.nil? && @experiment.trials.where(:outcome_good => nil).first) || Trial.new do |t|
      t.experiment_id = params[:id]
      t.should_do_action1 = [true, false].sample
      t.save!
    end
    @private = !@experiment.user_id.nil?
  end

  def new
  end

  def create
    @private = params[:experiments].delete(:private)
    params[:experiments][:user_id] = session[:user_id] if @private
  	@experiment = Experiment.new(params[:experiments])
  	if @experiment.save
  		redirect_to @experiment
  	else # validations fail 
  		redirect_to :home 
  	end
  end
end
