class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def show
  	@club_nights = current_user.club_nights.all
  end
end
