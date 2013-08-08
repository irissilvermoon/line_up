class ClubNightMembershipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_club_night

  def new
    @user = User.new
  end

  def create
    @user = @club_night.users.where(:email => params[:user][:email]).first

    if @user
      redirect_to club_night_club_night_memberships_path, notice: "User is already part of club night"
    else
      @user = User.invite!(params[:user])

      if @user.valid?
        @club_night.users << @user
        redirect_to club_night_club_night_memberships_path, notice: "{#user.email} has been added to #{@club_night.name}"
      else
        redirect_to new_club_night_club_night_membership_path, alert: "Email can't be blank"
      end
    end
  end

  def index
    @club_night_members = @club_night.users.all
  end

  private

  def find_club_night
    @club_night = current_user.club_nights.find(params[:club_night_id])
  end
end


