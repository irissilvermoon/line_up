class EventsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_club_night
  before_filter :find_event, :except => [:index, :new, :create]

  def new
    @event = @club_night.events.build
  end

  def create
    @event = @club_night.events.create(params[:event])

    if @event.persisted?
      flash[:notice] = "New event has been created."
      redirect_to [@club_night, @event]
    else
      flash[:alert] = "Event has not been created."
      render :action => "new"
    end
  end

  def show
    @time_slots = @event.time_slots.all

  end

  def edit

  end

  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Event has been updated."
      redirect_to [@club_night, @event]
    else
      flash[:alert] = "Event has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = "Event has been deleted."
    redirect_to club_night_path(@club_night)
  end

  private

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end

  def find_event
    @event = @club_night.events.find(params[:id])
  end
end
