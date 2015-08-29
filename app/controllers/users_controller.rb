class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def create
    @user = User.create(user_params)
    if @user.errors.any?
      flash[:errors] = @user.errors.full_messages
      redirect_to '/sessions/new'
    else
      session[:user_id] = @user.id
      redirect_to "/events"
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :location, :state)
  end

  private
  def edit_params
    params.require(:edit).permit(:first_name, :last_name, :email, :location, :state)
  end

end
