class ClubNightsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @club_nights = ClubNight.for(current_user).all
  end

  def new
    @club_night = current_user.club_nights.build
  end

  def create
    @club_night = current_user.club_nights.create(params[:club_night])

    if @club_night.persisted?
      flash[:notice] = "The club night #{@club_night.name} has been created."
      redirect_to club_night_path(@club_night)
    else
      flash[:alert] = "Club Night has not been created."
      render :action => "new"
    end
  end

  def show
    @club_night = ClubNight.find(params[:id])
  end

  def edit
    @club_night = ClubNight.find(params[:id])
  end

  def update
    @club_night = ClubNight.find(params[:id])
    if @club_night.update_attributes(params[:club_night])
      flash[:notice] = "#{@club_night.name} has been updated."
      redirect_to club_night_path(@club_night)
    else
      flash[:alert] = "#{club_night.name} has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @club_night = ClubNight.find(params[:id])
    @club_night.destroy
    flash[:notice] = "Club night has been deleted"
    redirect_to dashboard_path
  end
end
