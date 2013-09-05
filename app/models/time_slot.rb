class TimeSlot < ActiveRecord::Base
  attr_accessible :end_time, :genres, :notes, :start_time

  belongs_to :event

  delegate :club_night, :to => :event

  has_many :bookings
  has_many :djs, :through => :bookings

  validates_presence_of :start_time, :end_time

  def dj_ids=(ids)
    ids = ids.map { |id| Integer(id) rescue id }

    ids.each_with_index do |id, index|
      if id.is_a? String
        dj = club_night.djs.where(:dj_name => id).first_or_create
        ids[index] = dj.id
      end
    end

    super(ids)
  end
end
