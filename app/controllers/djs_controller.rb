class DjsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_club_night


  def index

  end

  def new
    @dj = @club_night.djs.build
  end

  def create
    @dj = @club_night.djs.create(params[:dj])

    if @dj.persisted?
      flash[:notice] = "The #{@dj.name} profile has been created."
      redirect_to [@club_night, @dj]
    else
      flash[:alert] = "DJ profile has not been created."
      render :action => "new"
    end
  end

  def show
    @dj = @club_night.djs.find(params[:id])
  end

  def edit
    @dj = @club_night.djs.find(params[:id])
  end

  def destroy
    @dj = @club_night.djs.find(params[:id])
    @dj.destroy
    flash[:notice] = "DJ has been deleted"
    redirect_to club_night_path(@club_night)
  end

  private

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end
end
