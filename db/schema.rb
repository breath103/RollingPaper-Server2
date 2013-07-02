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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130701122447) do

  create_table "image_contents", :force => true do |t|
    t.float    "x"
    t.float    "y"
    t.float    "width"
    t.float    "height"
    t.float    "rotation"
    t.integer  "paper_id"
    t.integer  "user_id"
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "paper_id"
    t.string   "frined_facebook_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "papers", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "creator_id"
    t.string   "friend_facebook_id"
    t.string   "notice"
    t.datetime "receive_time"
    t.integer  "width"
    t.integer  "height"
    t.string   "background"
  end

  add_index "papers", ["creator_id"], :name => "index_papers_on_user_id"

  create_table "sound_contents", :force => true do |t|
    t.float    "x"
    t.float    "y"
    t.float    "width"
    t.float    "height"
    t.float    "rotation"
    t.integer  "paper_id"
    t.integer  "user_id"
    t.string   "sound_file_name"
    t.string   "sound_content_type"
    t.integer  "sound_file_size"
    t.datetime "sound_updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "paper_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "email"
    t.string   "facebook_id"
    t.string   "facebook_accesstoken"
    t.string   "name"
    t.string   "picture"
    t.string   "birthday"
  end

end
