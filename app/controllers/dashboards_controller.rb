class DashboardsController < ApplicationController


  def show
    @club_nights = current_user.club_nights.all
  end
end
