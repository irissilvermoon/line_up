class Dj < ActiveRecord::Base
  attr_accessible :affiliations, :dj_name, :email,
  				  :facebook, :genres, :name, :phone,
  				  :slot_rating, :soundcloud, :twitter, :web, :club_night_id

  belongs_to :club_night

  has_many :events, :through => :bookings
  has_many :bookings
end
