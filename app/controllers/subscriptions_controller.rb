class SubscriptionsController < ApplicationController
	def new
		@subscription = Subscription.new
		@trial = params[:trial]
	end

	def create
		password = params[:subscription].delete(:password)
		params[:subscription][:email].downcase! # unique on this key
  	@subscription = Subscription.new(params[:subscription])
  	if @subscription.save_with_payment(password)
  		session[:user_id] = @subscription.user.id
    	redirect_to @subscription.user, :notice => "Thank you for subscribing!"
  	else
    	render :new
  	end
	end
end