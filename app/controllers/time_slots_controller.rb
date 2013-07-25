class TimeSlotsController < ApplicationController
  before_filter :find_club_night
  before_filter :find_event

  def new
    @time_slot = @event.time_slots.build
  end

  private

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end

  def find_event
    @event = @club_night.events.find(params[:id])
  end
end
