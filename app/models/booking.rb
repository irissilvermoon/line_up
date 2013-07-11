class Booking < ActiveRecord::Base
  attr_accessible :time_slot_id, :dj_id

  belongs_to :time_slot
  belongs_to :dj
end
