class ConfirmationsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @time_slot = TimeSlot.find(params[:time_slot_id])
    @event = @time_slot.event
    @club_night = current_user.club_nights.find(@event.club_night.id)
    @time_slot.confirmed_by = current_user
    @time_slot.save!
    head 200
  end

  def destroy
    @time_slot = TimeSlot.find(params[:time_slot_id])
    @event = @time_slot.event
    @club_night = current_user.club_nights.find(@event.club_night.id)

    @time_slot.confirmed_by = nil
    @time_slot.save!
    head 200
  end
end



