class ApplicationController < ActionController::Base
  protect_from_forgery
  #force_ssl # TODO SSL support

  protected
  def instance
		model_name = controller_name.classify
		model_name.constantize.find(params[:id]).tap do |i|
			instance_variable_set(:"@#{model_name.downcase}", i)
			yield i if block_given?
		end
  end


	private
	def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end
