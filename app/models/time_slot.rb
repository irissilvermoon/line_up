class TimeSlot < ActiveRecord::Base
  attr_accessible :end_time, :genres, :notes, :start_time
end
