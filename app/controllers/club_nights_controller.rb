class ClubNightsController < ApplicationController

	before_filter :authenticate_user!

	def index

	end

	def new
		@club_night = current_user.club_nights.build
	end

	def create
		@club_night = current_user.club_nights.build(params[:club_night])
		if @club_night.save
			flash[:notice] = "Club Night has been created."
			redirect_to club_night_path(@club_night)
		else
			flash[:alert] = "Club Night has not been created."
			render :action => "new"
		end
	end

	def show
		@club_night = ClubNight.find(params[:id])
	end
end
