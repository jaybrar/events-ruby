class MessagesController < ApplicationController

	def create
		@message = User.find(current_user).messages.create(message_params)
		if @message.errors.any?
          flash[:errors] = @message.errors.full_messages
          redirect_to '/resources'
        else
          redirect_to '/resources'
        end
	end

	def create2
		@message = User.find(current_user).messages.create(message_params)
		if @message.errors.any?
          flash[:errors] = @message.errors.full_messages
          redirect_to "/users/#{message_params[:receiver_id]}"
        else
          redirect_to '/users'
        end
	end

	def message_all
		users = User.all.where.not(id: current_user.id)
		users.each do |u|
			User.find(current_user).messages.create(message: params[:message], receiver_id: u.id)
		end
		redirect_to '/resources'
	end

	def destroy
		Message.find(params[:id]).destroy
		redirect_to '/users'
	end

	private
	def message_params
		params.require(:message).permit(:receiver_id, :message)
	end

end
