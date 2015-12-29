class Dj < ActiveRecord::Base
 

  validates_presence_of :dj_name

  belongs_to :club_night

  has_many :events, :through => :bookings
  has_many :bookings
end
