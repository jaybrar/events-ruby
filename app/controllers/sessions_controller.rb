class SessionsController < ApplicationController

	def new
	end

	def log_in
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/events"
		else
			flash[:error] = ['Invalid email/password combination']
			redirect_to '/sessions/new'
		end
	end

	def log_out
		session[:user_id] = nil
		redirect_to '/sessions/new'
	end
	
end
