class AddClubNightIdToDjs < ActiveRecord::Migration
  def change
    add_column :djs, :club_night_id, :integer
  end
end
