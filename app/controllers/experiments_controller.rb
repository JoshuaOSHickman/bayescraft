class ExperimentsController < ApplicationController
 	def index
		@experiments = Experiment.where(:user_id => nil).first(5)
    @private = false
  end

  def show
  	@experiment = Experiment.find(params[:id])
    redirect_to login_url unless @experiment.user_id.nil? || (current_user && current_user.id == @experiment.user_id)
    # if there is a user and an unfinished trial, give that, or a new trial
    if @experiment.user_id.nil?
      @trial = @experiment.new_trial
      @private = false
    else
      if existing_trial = @experiment.trials.where(:outcome_good => nil).first
        @trial = existing_trial
      else
        @trial = @experiment.new_trial
      end
      @private = true
    end
  end

  def new
    @private = params[:private]
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
