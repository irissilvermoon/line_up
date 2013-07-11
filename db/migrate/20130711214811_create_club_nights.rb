class CreateClubNights < ActiveRecord::Migration
  def change
    create_table :club_nights do |t|
      t.string :name
      t.string :venue
      t.string :genres
      t.datetime :start_time
      t.datetime :end_time
      t.text :notes

      t.timestamps
    end
  end
end
