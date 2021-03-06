class ClubNightsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :find_club_night, :except => [:index, :new, :create]

  def index
    @club_nights = current_user.club_nights.all
  end

  def new
    @club_night = current_user.club_nights.build
  end

  def create
    @club_night = current_user.club_nights.create(club_night_params)

    if @club_night.persisted?
      flash[:notice] = "The club night #{@club_night.name} has been created."
      redirect_to club_night_path(@club_night)
    else
      flash[:alert] = "Club Night has not been created."
      render :action => "new"
    end
  end

  def show
    @djs = @club_night.djs.all
    @events = @club_night.events.all
    @events_by_date = @events.group_by { |e| e.date.to_date }
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @users = @club_night.users.all
  end

  def edit

  end

  def update
    if @club_night.update_attributes(club_night_params)
      flash[:notice] = "#{@club_night.name} has been updated."
      redirect_to club_night_path(@club_night)
    else
      flash[:alert] = "#{@club_night.name} has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @club_night.destroy
    flash[:notice] = "Club night has been deleted"
    redirect_to dashboard_path
  end

  private

  def club_night_params
    params.require(:club_night).permit(:end_time, :genres, :name, :notes, :start_time, :venue)
  end

  def find_club_night
    @club_night = current_user.club_nights.find(params[:id])
  end
end
