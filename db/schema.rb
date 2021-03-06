# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151230231220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer  "time_slot_id"
    t.integer  "dj_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "club_night_memberships", force: :cascade do |t|
    t.integer  "club_night_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "club_nights", force: :cascade do |t|
    t.string   "name"
    t.string   "venue"
    t.string   "genres"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "djs", force: :cascade do |t|
    t.string   "name"
    t.string   "dj_name"
    t.string   "genres"
    t.string   "affiliations"
    t.string   "slot_rating"
    t.string   "phone"
    t.string   "email"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "soundcloud"
    t.string   "web"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "club_night_id"
    t.text     "notes"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "club_night_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.string   "location"
    t.datetime "date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "notes"
  end

  create_table "time_slots", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "genres"
    t.text     "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "event_id"
    t.integer  "confirmed_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.datetime "invitation_created_at"
    t.string   "invitation_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
