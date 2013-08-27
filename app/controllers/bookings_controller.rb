class BookingsController < ApplicationController
  #new/create for adding a DJ to a time slot
  #it should create a DJ in the system
  #destroy for removing a DJ from a time slot
  #eventually will populate bookings via the time slot model
  #need to find club night from the time slot and 404 if the user doesn't belong to the club night
  #head 404
  #on time slots page have "add DJ" brings you to booking page.
  before_filter :authenticate_user!
  before_filter :find_club_night
  before_filter :find_event
  before_filter :find_time_slot


  def new
    @booking = Booking.new
  end

  private

  def find_time_slot
    @time_slot = @event.time_slots.find(params[:id])
  end

  def find_event
    @event = @club_night.events.find(params[:event_id])
  end

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end
end