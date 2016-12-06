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

ActiveRecord::Schema.define(version: 20161204184233) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "picture_url_override"
    t.string   "text"
    t.string   "time"
    t.string   "location"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "goal_encouragements", force: :cascade do |t|
    t.integer  "goal_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "text"
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitation_responses", force: :cascade do |t|
    t.integer  "invitation_id"
    t.integer  "user_id"
    t.string   "response"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "what"
    t.string   "details"
    t.string   "where"
    t.string   "when"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fb_messenger_id"
    t.string   "fb_profile_id"
    t.string   "first_name"
    t.string   "full_name"
    t.string   "picture_url"
    t.boolean  "ignore",            default: false
    t.string   "last_message_sent"
    t.string   "interests"
    t.string   "availability"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["fb_messenger_id"], name: "index_users_on_fb_messenger_id"
    t.index ["fb_profile_id"], name: "index_users_on_fb_profile_id"
  end

end
