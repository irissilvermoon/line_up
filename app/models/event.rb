class Event < ActiveRecord::Base
  attr_accessible :club_night_id

  belongs_to :club_night

  has_many :time_slots
  has_many :bookings, :through => :time_slots
  has_many :djs, :through => :bookings
end
