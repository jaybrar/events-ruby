class ResourcesController < ApplicationController

	def index
		@users = User.all
		@hash = Gmaps4rails.build_markers(@users) do |user, marker|
	    marker.lat user.latitude
	    marker.lng user.longitude
	    marker.infowindow render_to_string(partial: "maps", locals: {user: user})
	    # marker.picture({
     #    "url": "http://i.stack.imgur.com/rU427.png",
     #    "width":  36,
     #    "height": 36
	    #   })
	    end
	end

	def create
		@resource = User.find(current_user).resources.create(resource_params)
		if @resource.errors.any?
          flash[:errors] = @resource.errors.full_messages
          redirect_to '/users'
        else
       #    resource = current_user.resources.last
	      # users = User.all 
	      # users.each do |u|
	      # AddResource.add(u, current_user, resource).deliver!
	      # end
	      redirect_to '/users'
        end
	end

	def edit
		@resource = Resource.find(params[:id])
	end

	def update
	    resource = Resource.find(params[:id])
	    resource.update(edit_params)
	    if resource.errors.any?
	      flash[:errors] = resource.errors.full_messages
	      redirect_to "/resources/#{params[:id]}/edit"
	    else
	      redirect_to "/users"
	    end
	end

	def destroy
		resource = Resource.find(params[:id]).destroy
	 #    users = User.all 
	 #    users.each do |u|
	 #    DeleteResource.delete(u, current_user, resource).deliver!
		# end
		redirect_to '/users'
	end

	private
	def resource_params
		params.require(:resource).permit(:name, :description)
	end

	private 
	def edit_params
		params.require(:edit).permit(:name, :description)
	end

end
