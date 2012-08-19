class UserController < ApplicationController
	def show
		redirect_to login_url if (session[:user_id].to_i != params[:id].to_i) || instance.subscription.disabled?

		instance do |user|
			@experiments = @user.experiments
		end
	end

	def destroy
		redirect_to login_url if session[:user_id].to_i != params[:id].to_i || instance.subscription.disabled?
		instance.subscription.cancel
		redirect_to logout_url
	end
end