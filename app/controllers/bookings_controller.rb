class BookingsController < ApplicationController
  #new/create for adding a DJ to a time slot
  #it should create a DJ in the system
  #destroy for removing a DJ from a time slot
  #eventually will populate bookings via the time slot model
  #need to find club night from the time slot and 404 if the user doesn't belong to the club night
  #head 404
  #on time slots page have "add DJ" brings you to booking page.
  before_filter :authenticate_user!
  before_filter :find_time_slot
  before_filter :find_event
  before_filter :find_club_night


  def new
    @booking = @time_slot.bookings.build
  end

  private

  def find_time_slot
    @time_slot = TimeSlot.find(params[:time_slot_id])
  end

  def find_event
    @event = @time_slot.event
  end

  def find_club_night
    @club_night = @event.club_night
    @user = current_user.club_nights.find(@club_night.id)
  end
end
