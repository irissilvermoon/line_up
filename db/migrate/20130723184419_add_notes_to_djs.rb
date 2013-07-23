class AddNotesToDjs < ActiveRecord::Migration
  def change
    add_column :djs, :notes, :text
  end
end
