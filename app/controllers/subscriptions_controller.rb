class SubscriptionsController < ApplicationController
	def new
		@subscription = Subscription.new
	end

	def create
		password = params[:subscription].delete(:password)
  	@subscription = Subscription.new(params[:subscription])
  	if @subscription.save_with_payment(password)
  		session[:user_id] = @subscription.user.id
    	redirect_to @subscription.user, :notice => "Thank you for subscribing!"
  	else
    	render :new
  	end
	end
end