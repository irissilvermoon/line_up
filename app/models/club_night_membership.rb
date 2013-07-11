class ClubNightMembership < ActiveRecord::Base
  attr_accessible :club_night_id, :user_id

  belongs_to :club_night
  belongs_to :user
end
