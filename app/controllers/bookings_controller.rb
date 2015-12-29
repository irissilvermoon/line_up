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
    @djs = @club_night.djs.all
    @booking = @time_slot.bookings.build
  end

  def create
    @booking = @time_slot.bookings.where(params[:id]).first

    if @booking
      flash[:notice] = "DJ has already been added to time slot"
      redirect_to [@club_night, @event, @time_slot]
    else
      @booking = @time_slot.bookings.create(booking_params)

      if @booking.persisted?
        flash[:notice] = "DJ has been added to Time Slot"
        redirect_to [@club_night, @event, @time_slot]
      else
        flash[:alert] = "Dj has not been added to Time Slot"
        render :action => "new"
      end
    end
  end

  def destroy
    @booking = @time_slot.bookings.find(params[:id])

    @booking.destroy
    flash[:notice] = "DJ has been removed from Time Slot"
    redirect_to [@club_night, @event, @time_slot]
  end

  private

  def booking_params
    params.require(:booking).permit(:time_slot_id, :dj_id)
  end

  def find_time_slot
    @time_slot = TimeSlot.find(params[:time_slot_id])
  end

  def find_event
    @event = @time_slot.event
  end

  def find_club_night
    @club_night = current_user.club_nights.find(@event.club_night.id)
  end
end

