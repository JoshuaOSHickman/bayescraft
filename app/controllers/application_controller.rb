class ApplicationController < ActionController::Base
  protect_from_forgery

  def instance
		model_name = controller_name.classify
		model_name.constantize.find(params[:id]).tap do |i|
			instance_variable_set(:"@#{model_name.downcase}", i)
			yield i if block_given?
		end
  end
end
