class ClubNight < ActiveRecord::Base
  has_many :djs
  has_many :users, :through => :club_night_memberships
  has_many :club_night_memberships
  has_many :events

  validates_presence_of :name, :start_time, :end_time
end
