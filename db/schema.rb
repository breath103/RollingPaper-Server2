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

ActiveRecord::Schema.define(:version => 20130630084410) do

  create_table "image_contents", :force => true do |t|
    t.float   "x"
    t.float   "y"
    t.float   "width"
    t.float   "height"
    t.float   "rotation"
    t.integer "paper_id"
    t.integer "user_id"
    t.string  "image"
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
