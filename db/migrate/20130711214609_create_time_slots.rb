class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :genres
      t.text :notes

      t.timestamps
    end
  end
end
