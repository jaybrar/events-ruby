class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @user = User.find(current_user)
    @resources = User.find(current_user).resources
    @messages = Message.includes(:user).where(receiver_id: current_user)
    # Message.select('*').joins(:user).where("receiver_id = 1")
  end

  def create
    @user = User.create(user_params)
    if @user.errors.any?
      flash[:errors] = @user.errors.full_messages
      redirect_to '/sessions/new'
    else
      Signup.welcome_email(@user).deliver!
      session[:user_id] = @user.id
      redirect_to "/events"
    end
  end

  def show
    @user = User.find(params[:id])
    @resources = @user.resources
    @hash = Gmaps4rails.build_markers(@user) do |user, marker|
    marker.lat user.latitude
    marker.lng user.longitude
    marker.infowindow render_to_string(partial: "resources/maps", locals: {user: user})
      # marker.picture({
     #    "url": "http://i.stack.imgur.com/rU427.png",
     #    "width":  36,
     #    "height": 36
      #   })
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(edit_params)
    if @user.errors.any?
      flash[:errors] = @user.errors.full_messages
      render 'edit'
    else
      redirect_to "/events"
    end

  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :location, :state, :group, :address)
  end

  private
  def edit_params
    params.require(:edit).permit(:first_name, :last_name, :email, :location, :state, :group, :address)
  end

end
