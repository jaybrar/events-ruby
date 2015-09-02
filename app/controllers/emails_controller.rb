class EmailsController < ApplicationController

	def create
		# message = params[:message]
		# users = User.all
		# users.each do |user|
		# EmailBlast.email_all(user, current_user, message).deliver!
		# end
		redirect_to '/resources'
	end
end
