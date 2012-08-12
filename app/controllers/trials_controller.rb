class TrialsController < ApplicationController
	def edit
		instance
	end

	def update
		instance do |trial|
			trial.outcome_good = params[:outcome_good]
			trial.save!
		end
	end

	def bork
		instance do |trial|
			trial.borked = true
			trial.save!
		end
	end
end