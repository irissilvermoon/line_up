class CreateClubNightMemberships < ActiveRecord::Migration
  def change
    create_table :club_night_memberships do |t|
      t.integer :club_night_id
      t.integer :user_id

      t.timestamps
    end
  end
end
