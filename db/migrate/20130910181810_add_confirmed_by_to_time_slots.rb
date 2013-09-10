class AddConfirmedByToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :confirmed_by, :integer
  end
end
