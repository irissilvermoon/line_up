class DjsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_club_night
  before_filter :find_dj, :except => [:index, :new, :create]


  def index
    @djs = @club_night.djs

    if params[:q]
      @djs = @djs.where('dj_name LIKE ?', "%#{params[:q]}%")
    end

    respond_to do |format|
      format.html
      if format.json { render :json => @djs }
        if @djs.empty? && params[:q]
          @djs = [{dj_name: "New DJ: #{params[:q]}", id: "#{params[:q]}"}]
        end
      end
    end

    #if @djs.empty? && params[:q]
  end

  def new
    @dj = @club_night.djs.build
  end

  def create
    @dj = @club_night.djs.create(params[:dj])

    if @dj.persisted?
      flash[:notice] = "#{@dj.dj_name}'s profile has been created."
      redirect_to [@club_night, @dj]
    else
      flash[:alert] = "DJ profile has not been created."
      render :action => "new"
    end
  end

  def show

  end

  def edit

  end

  def update
    if @dj.update_attributes(params[:dj])
      flash[:notice] = "#{@dj.dj_name}'s profile has been updated."
      redirect_to [@club_night, @dj]
    else
      flash[:alert] = "Profile has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @dj.destroy
    flash[:notice] = "DJ has been deleted."
    redirect_to club_night_path(@club_night)
  end

  private

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end

  def find_dj
    @dj = @club_night.djs.find(params[:id])
  end
end
