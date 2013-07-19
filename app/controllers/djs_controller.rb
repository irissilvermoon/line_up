class DjsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @dj = @club_night.djs.build
  end

  def create
    @dj = @club_night.djs.create(params[:dj])

    if @club_night.persisted?
      flash[:notice] = "The #{@dj.name} profile has been created."
      redirect_to club_night_dj_path(@dj)
    else
      flash[:alert] = "DJ profile has not been created."
      render :action => "new"
    end
  end
end
