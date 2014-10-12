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

ActiveRecord::Schema.define(version: 20141012091334) do

  create_table "events", force: true do |t|
    t.integer  "notifier_id"
    t.string   "file_name"
    t.datetime "file_mtime"
    t.string   "absolute_file_path"
    t.string   "ownership"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["notifier_id", "file_name"], name: "index_events_on_notifier_id_and_file_name", unique: true

  create_table "notifiers", force: true do |t|
    t.string   "path",       default: "", null: false
    t.string   "pattern",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifiers", ["path"], name: "index_notifiers_on_path", unique: true

end
