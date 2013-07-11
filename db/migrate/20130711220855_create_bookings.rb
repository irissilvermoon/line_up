class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :time_slot_id
      t.integer :dj_id

      t.timestamps
    end
  end
end
