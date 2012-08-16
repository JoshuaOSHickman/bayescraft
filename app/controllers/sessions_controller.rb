class SessionsController < ApplicationController
	def new
	end

	def create
		subscription = Subscription.find_by_email(params[:email])
		if subscription && subscription.user.authenticate(params[:password])
			user = subscription.user
			session[:user_id] = user.id
			redirect_to user, :notice => "Logged In!"
		else
			flash.now.alert = "Invalid Email or Password"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end
end