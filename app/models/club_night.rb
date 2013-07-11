class ClubNight < ActiveRecord::Base
  attr_accessible :end_time, :genres, :name, :notes, :start_time, :venue
end
