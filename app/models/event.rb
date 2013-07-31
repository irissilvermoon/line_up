class Event < ActiveRecord::Base
  attr_accessible :name, :location, :date, :start_time, :end_time

  belongs_to :club_night

  has_many :time_slots
  has_many :bookings, :through => :time_slots
  has_many :djs, :through => :bookings

  validates_presence_of :name, :start_time, :end_time

  def date=(date)
    date = Time.parse(date)
    self[:date] = date
  end
end
