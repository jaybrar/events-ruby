class AttendeesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]

	  def create
	  	event = Event.find(params[:id])
	  	Attendee.create(user: current_user, event: event)
	  	redirect_to '/events'
	  end

	  def destroy
	  	# Attendee.where(user: User.find(current_user), event: params[:id]).destroy_all
	  	 # this works also
	    Attendee.find_by(user: User.find(current_user), event: params[:id]).destroy
	  	redirect_to '/events'
	  end
end
