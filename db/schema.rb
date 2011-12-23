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

ActiveRecord::Schema.define(:version => 20111222203623) do

  create_table "address_records", :force => true do |t|
    t.string   "address"
    t.integer  "person_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "address_records", ["address", "person_id"], :name => "index_address_records_on_address_and_person_id", :unique => true
  add_index "address_records", ["address"], :name => "index_address_records_on_address"
  add_index "address_records", ["person_id"], :name => "index_address_records_on_person_id"

  create_table "areas", :force => true do |t|
    t.decimal  "latitude",   :precision => 15, :scale => 10
    t.decimal  "longitude",  :precision => 15, :scale => 10
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "areas", ["user_id"], :name => "index_areas_on_user_id"

  create_table "email_records", :force => true do |t|
    t.string   "email"
    t.integer  "person_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ip_records", :force => true do |t|
    t.integer  "person_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
  end

  add_index "ip_records", ["ip_address"], :name => "index_ip_records_on_ip_address"
  add_index "ip_records", ["person_id", "ip_address"], :name => "index_ip_records_on_person_id_and_ip_address", :unique => true

  create_table "ips", :force => true do |t|
    t.integer  "rumor_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dist",                                      :default => 0
    t.string   "name",                                      :default => "*"
    t.integer  "age",                                       :default => 0
    t.boolean  "gender",                                    :default => false
    t.string   "twitter",                                   :default => "*"
    t.string   "facebook",                                  :default => "*"
    t.string   "linkedin",                                  :default => "*"
    t.string   "wikipedia",                                 :default => "*"
    t.string   "tumblr",                                    :default => "*"
    t.decimal  "lat_avg",    :precision => 10, :scale => 0
    t.decimal  "lng_avg",    :precision => 10, :scale => 0
  end

  add_index "people", ["dist"], :name => "index_people_on_dist"
  add_index "people", ["facebook"], :name => "index_people_on_facebook"
  add_index "people", ["lat_avg", "lng_avg"], :name => "index_people_on_lat_avg_and_lng_avg"
  add_index "people", ["linkedin"], :name => "index_people_on_linkedin"
  add_index "people", ["name"], :name => "index_people_on_name"
  add_index "people", ["tumblr"], :name => "index_people_on_tumblr"
  add_index "people", ["twitter"], :name => "index_people_on_twitter"
  add_index "people", ["wikipedia"], :name => "index_people_on_wikipedia"

  create_table "phone_records", :force => true do |t|
    t.integer  "person_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "phone_number"
  end

  add_index "phone_records", ["person_id", "phone_number"], :name => "index_phone_records_on_person_id_and_phone_number", :unique => true
  add_index "phone_records", ["phone_number"], :name => "index_phone_records_on_phone_number"

  create_table "relationships", :force => true do |t|
    t.integer  "person_id"
    t.integer  "affliation_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rumor_records", :force => true do |t|
    t.integer  "person_id"
    t.integer  "rumor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rumor_records", ["person_id", "rumor_id"], :name => "index_rumor_records_on_person_id_and_rumor_id", :unique => true
  add_index "rumor_records", ["person_id"], :name => "index_rumor_records_on_person_id"
  add_index "rumor_records", ["rumor_id"], :name => "index_rumor_records_on_rumor_id"

  create_table "rumors", :force => true do |t|
    t.text     "content"
    t.decimal  "latitude",   :precision => 15, :scale => 10
    t.decimal  "longitude",  :precision => 15, :scale => 10
    t.boolean  "gmaps"
    t.integer  "zoom_level",                                 :default => 1
    t.integer  "parent_id"
    t.string   "pic"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  add_index "rumors", ["person_id"], :name => "index_rumors_on_person_id"
  add_index "rumors", ["user_id"], :name => "index_rumors_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
