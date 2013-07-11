class CreateDjs < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :name
      t.string :dj_name
      t.string :genres
      t.string :affiliations
      t.string :slot_rating
      t.string :phone
      t.string :email
      t.string :facebook
      t.string :twitter
      t.string :soundcloud
      t.string :web

      t.timestamps
    end
  end
end
