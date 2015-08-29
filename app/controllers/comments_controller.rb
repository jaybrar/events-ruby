class CommentsController < ApplicationController

  def create
  	comment = Event.find(params[:id]).comments.create(user: current_user, content: params[:content])
  	if comment.errors.any?
  		flash[:errors] = comment.errors.full_messages
  		redirect_to "/events/#{params[:id]}"
  	else
  		redirect_to "/events/#{params[:id]}"
  	end

  end
end
