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

ActiveRecord::Schema.define(version: 20140115145151) do

  create_table "activity_categories", force: true do |t|
    t.string "name"
  end

  create_table "activity_categories_ideas", force: true do |t|
    t.integer "activity_category_id"
    t.integer "idea_id"
  end

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "rating"
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "idea_ratings", force: true do |t|
    t.integer  "rating"
    t.integer  "idea_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "idea_visits", force: true do |t|
    t.integer  "idea_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "download",   default: false
  end

  create_table "ideas", force: true do |t|
    t.string   "title"
    t.string   "location"
    t.integer  "duration_preparation"
    t.integer  "duration_total"
    t.string   "information"
    t.string   "material"
    t.string   "security"
    t.string   "remarks"
    t.text     "start"
    t.text     "main_part"
    t.text     "end"
    t.integer  "duration_start"
    t.integer  "duration_main_part"
    t.integer  "duration_end"
    t.boolean  "published",            default: false
    t.integer  "downloads",            default: 0
    t.integer  "views",                default: 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_size_min"
    t.integer  "group_size_max"
    t.integer  "age_min"
    t.integer  "age_max"
    t.boolean  "boys"
    t.boolean  "girls"
    t.string   "preparation"
  end

  create_table "ideas_location_categories", force: true do |t|
    t.integer "idea_id"
    t.integer "location_category_id"
  end

  create_table "ideas_method_categories", force: true do |t|
    t.integer "idea_id"
    t.integer "method_category_id"
  end

  create_table "ideas_season_categories", force: true do |t|
    t.integer "idea_id"
    t.integer "season_category_id"
  end

  create_table "location_categories", force: true do |t|
    t.string "name"
  end

  create_table "method_categories", force: true do |t|
    t.string "name"
  end

  create_table "redactor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], name: "idx_redactor_assetable", using: :btree
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_redactor_assetable_type", using: :btree

  create_table "season_categories", force: true do |t|
    t.string "name"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "moderator",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
