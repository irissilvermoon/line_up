class RenameConfirmedByForeignKey < ActiveRecord::Migration
  def change
    rename_column :time_slots, :confirmed_by, :confirmed_by_id
  end
end
