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

ActiveRecord::Schema.define(version: 20161123184144) do

  create_table "users", force: :cascade do |t|
    t.string   "fb_messenger_id"
    t.string   "fb_profile_id"
    t.boolean  "ignore",            default: false
    t.string   "last_message_sent"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["fb_messenger_id"], name: "fb_messenger_id_idx"
    t.index ["fb_profile_id"], name: "fb_profile_id_idx"
  end

end
