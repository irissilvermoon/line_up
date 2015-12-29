class TimeSlotsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_club_night
  before_filter :find_event
  before_filter :find_time_slot, :except => [:index, :new, :create]

  def new
    @time_slot = @event.time_slots.build
  end

  def create
    @time_slot = @event.time_slots.where(:event_id => @event.id).create(time_slot_params)

    if @time_slot.persisted?
      flash[:notice] = "New time slot added."
      redirect_to [@club_night, @event]
    else
      flash[:alert] = "Time slot has not been added."
      render :action => "new"
    end
  end

  def show
    @djs = @time_slot.djs.all
  end

  def edit

  end

  def update
    if @time_slot.update_attributes(time_slot_params)
      flash[:notice] = "Time Slot has been updated"
      redirect_to [@club_night, @event]
    else
      flash[:alert] = "Time Slot has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @time_slot.destroy
    flash[:notice] = "Time slot has been removed"
    redirect_to club_night_event_path(@club_night, @event)
  end

  private

  def time_slot_params
    params.require(:time_slot).permit(:end_time, :genres, :notes, :start_time, :dj_ids, :dj_id_list)
  end

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end

  def find_event
    @event = @club_night.events.find(params[:event_id])
  end

  def find_time_slot
    @time_slot = @event.time_slots.find(params[:id])
  end
end
