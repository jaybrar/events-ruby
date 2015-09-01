class EventsController < ApplicationController
  before_action :require_login
  # before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def index
    @user = User.find(session[:user_id])
    state = @user.state
    # @count = @attendees.count
    @event = Event.includes(:user).where(state: state)
    @event2 = Event.includes(:user).where.not(state: state)
    @events = Event.all
    @hash = Gmaps4rails.build_markers(@events) do |e, marker|
      marker.lat e.latitude
      marker.lng e.longitude
      marker.infowindow render_to_string(partial: "maps", locals: {event: e, count: e.users_attended.count})
      # marker.picture({
     #    "url": "http://i.stack.imgur.com/rU427.png",
     #    "width":  36,
     #    "height": 36
      #   })
      end
  end

  def show
    @event = Event.find(params[:id])
    @attendees = Event.find(params[:id]).users_attended
    @count = @attendees.count
    @comments = Comment.includes(:user, :event).where("event_id = #{params[:id]}")
    @hash = Gmaps4rails.build_markers(@event) do |e, marker|
      marker.lat e.latitude
      marker.lng e.longitude
      marker.infowindow render_to_string(partial: "maps", locals: {event: e, count: @count})
      # marker.picture({
     #    "url": "http://i.stack.imgur.com/rU427.png",
     #    "width":  36,
     #    "height": 36
      #   })
      end
  end

  def create
      @event = User.find(params[:id]).events.create(event_params)
        if @event.errors.any?
          flash[:errors] = @event.errors.full_messages
          redirect_to '/events'
          # errors = {:errors => flash[:errors]}
        else
          @user = User.find(session[:user_id])
          state = @user.state
          @event = Event.includes(:user).where(state: state)
          @event2 = Event.includes(:user).where.not(state: state)
          redirect_to '/events'
          # render "index"
        end
  end

  def update
    event = Event.find(params[:id])
    event.update(edit_params)
    if event.errors.any?
      flash[:errors] = event.errors.full_messages
      redirect_to "/events/#{params[:id]}/edit"
    else
      redirect_to "/events"
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to '/events'
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :address, :location, :state)
  end

  private
  def edit_params
    params.require(:edit).permit(:name, :date, :address, :location, :state)
  end

end
