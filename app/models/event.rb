class Event < ActiveRecord::Base
  attr_accessible :club_night_id, :name, :location, :date, :start_time, :end_time

  belongs_to :club_night

  has_many :time_slots
  has_many :bookings, :through => :time_slots
  has_many :djs, :through => :bookings

  validates_presence_of :name, :start_time, :end_time
end
