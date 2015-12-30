class ClubNightMembership < ActiveRecord::Base


  belongs_to :club_night
  belongs_to :user
end
