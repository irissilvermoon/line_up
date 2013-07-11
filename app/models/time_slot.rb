class TimeSlot < ActiveRecord::Base
  attr_accessible :end_time, :genres, :notes, :start_time

  belongs_to :event

  has_many :bookings
  has_many :djs, :through => :bookings
end
