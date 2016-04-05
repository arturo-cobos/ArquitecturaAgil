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

ActiveRecord::Schema.define(version: 20160404061537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.datetime "alert_date"
    t.integer  "pet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "alerts", ["pet_id"], name: "index_alerts_on_pet_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.datetime "date"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "pet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "locations", ["pet_id"], name: "index_locations_on_pet_id", using: :btree

  create_table "pets", force: :cascade do |t|
    t.string   "name"
    t.string   "breed"
    t.date     "birthday"
    t.string   "characteristics"
    t.string   "contact"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pets", ["user_id"], name: "index_pets_on_user_id", using: :btree

  create_table "safe_zones", force: :cascade do |t|
    t.float    "coorX1"
    t.float    "coorX2"
    t.float    "coorY1"
    t.float    "coorY2"
    t.integer  "pet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "safe_zones", ["pet_id"], name: "index_safe_zones_on_pet_id", using: :btree

  create_table "statistics", force: :cascade do |t|
    t.float    "t_zero"
    t.float    "t_one"
    t.float    "t_two"
    t.float    "t_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "document_id"
    t.string   "last_name"
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "vital_signs", force: :cascade do |t|
    t.integer  "systolic_p"
    t.integer  "diastolic_p"
    t.integer  "heart_rate"
    t.integer  "breathing_rate"
    t.integer  "pet_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "vital_signs", ["pet_id"], name: "index_vital_signs_on_pet_id", using: :btree

  add_foreign_key "alerts", "pets"
  add_foreign_key "locations", "pets"
  add_foreign_key "pets", "users"
  add_foreign_key "safe_zones", "pets"
  add_foreign_key "vital_signs", "pets"
end
