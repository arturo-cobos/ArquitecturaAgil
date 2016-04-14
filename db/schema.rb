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

ActiveRecord::Schema.define(version: 20160412233846) do

  create_table "collars", force: :cascade do |t|
    t.integer  "pet_id",      limit: 4
    t.string   "reference",   limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "collars", ["pet_id"], name: "index_collars_on_pet_id", using: :btree

  create_table "location_histories", force: :cascade do |t|
    t.integer  "pet_id",      limit: 4
    t.datetime "record_date"
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "location_histories", ["pet_id"], name: "index_location_histories_on_pet_id", using: :btree

  create_table "owners", force: :cascade do |t|
    t.string   "email",       limit: 255
    t.string   "name",        limit: 255
    t.string   "last_name",   limit: 255
    t.string   "document_id", limit: 255
    t.string   "phone",       limit: 255
    t.string   "cellphone",   limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "pet_statuses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "pet_types", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "pets", force: :cascade do |t|
    t.integer  "pet_type_id",   limit: 4
    t.integer  "pet_status_id", limit: 4
    t.integer  "owner_id",      limit: 4
    t.string   "name",          limit: 255
    t.string   "gender",        limit: 255
    t.string   "description",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "pets", ["owner_id"], name: "index_pets_on_owner_id", using: :btree
  add_index "pets", ["pet_status_id"], name: "index_pets_on_pet_status_id", using: :btree
  add_index "pets", ["pet_type_id"], name: "index_pets_on_pet_type_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.integer  "collar_id",      limit: 4
    t.float    "latitude",       limit: 24
    t.float    "longitude",      limit: 24
    t.integer  "breathing_freq", limit: 4
    t.integer  "heart_freq",     limit: 4
    t.integer  "systolic",       limit: 4
    t.integer  "diastolic",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "records", ["collar_id"], name: "index_records_on_collar_id", using: :btree

  create_table "safe_zones", force: :cascade do |t|
    t.integer  "pet_id",     limit: 4
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
    t.float    "radium",     limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "safe_zones", ["pet_id"], name: "index_safe_zones_on_pet_id", using: :btree

  create_table "vitalsign_histories", force: :cascade do |t|
    t.integer  "pet_id",         limit: 4
    t.datetime "record_date"
    t.integer  "breathing_freq", limit: 4
    t.integer  "heart_freq",     limit: 4
    t.integer  "systolic",       limit: 4
    t.integer  "diastolic",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "vitalsign_histories", ["pet_id"], name: "index_vitalsign_histories_on_pet_id", using: :btree

  add_foreign_key "collars", "pets"
  add_foreign_key "location_histories", "pets"
  add_foreign_key "pets", "owners"
  add_foreign_key "pets", "pet_statuses"
  add_foreign_key "pets", "pet_types"
  add_foreign_key "records", "collars"
  add_foreign_key "safe_zones", "pets"
  add_foreign_key "vitalsign_histories", "pets"
end
