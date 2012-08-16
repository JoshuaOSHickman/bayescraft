class UserController < ApplicationController
	def show
		# TODO show personal experiments and such
		redirect_to login_url if session[:user_id].to_i != params[:id].to_i

		instance do |user|
			@experiments = @user.experiments
		end
	end
end