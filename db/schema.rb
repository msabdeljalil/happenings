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

ActiveRecord::Schema.define(version: 20150123211918) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: true do |t|
    t.integer "user_id"
    t.integer "performance_date_id"
  end

  add_index "attendances", ["user_id", "performance_date_id"], name: "index_attendances_on_user_id_and_performance_date_id", using: :btree
  add_index "attendances", ["user_id", "performance_date_id"], name: "uniqueness", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "run_time"
    t.text     "description"
    t.integer  "venue_id"
    t.string   "style"
    t.string   "price"
    t.string   "box_office_num"
    t.string   "tickets_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performance_dates", force: true do |t|
    t.datetime "dtstart"
    t.integer  "event_id"
    t.datetime "dtend"
  end

  add_index "performance_dates", ["event_id"], name: "index_performance_dates_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string "name"
    t.string "address"
  end

end
