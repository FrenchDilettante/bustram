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

ActiveRecord::Schema.define(version: 20141201103235) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: true do |t|
    t.string   "code"
    t.integer  "lat"
    t.integer  "lon"
    t.integer  "stop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routes", force: true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transport_type"
  end

  create_table "schedules", force: true do |t|
    t.integer "trip_id"
    t.integer "stop_id"
    t.integer "location_id"
    t.integer "departure_time"
    t.integer "stop_sequence"
  end

  create_table "stops", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "timeframes", force: true do |t|
    t.string  "code"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.date    "start_date"
    t.date    "end_date"
  end

  create_table "trips", force: true do |t|
    t.integer "route_id"
    t.integer "timeframe_id"
    t.string  "code"
    t.string  "headsign"
    t.integer "direction_id"
  end

end
