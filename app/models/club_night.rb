class ClubNight < ActiveRecord::Base
  attr_accessible :end_time, :genres, :name, :notes, :start_time, :venue

  has_many :djs
  has_many :users, :through => :club_night_memberships
  has_many :club_night_memberships
  has_many :events

  validates_presence_of :name, :start_time, :end_time
end
