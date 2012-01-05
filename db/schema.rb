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

ActiveRecord::Schema.define(:version => 20120105003910) do

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

  create_table "city_records", :force => true do |t|
    t.integer  "person_id"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",      :default => 1
  end

  add_index "city_records", ["city"], :name => "index_city_records_on_city"
  add_index "city_records", ["person_id", "city"], :name => "index_city_records_on_person_id_and_city", :unique => true
  add_index "city_records", ["person_id"], :name => "index_city_records_on_person_id"

  create_table "country_records", :force => true do |t|
    t.integer  "person_id"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",      :default => 1
  end

  add_index "country_records", ["country"], :name => "index_country_records_on_country"
  add_index "country_records", ["person_id", "country"], :name => "index_country_records_on_person_id_and_country", :unique => true
  add_index "country_records", ["person_id"], :name => "index_country_records_on_person_id"

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
  add_index "ip_records", ["person_id"], :name => "index_ip_records_on_person_id"

  create_table "ips", :force => true do |t|
    t.integer  "rumor_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "macroposts", :force => true do |t|
    t.integer  "moderator_id"
    t.text     "content"
    t.string   "board"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moderators", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "moderators", ["email"], :name => "index_moderators_on_email", :unique => true
  add_index "moderators", ["reset_password_token"], :name => "index_moderators_on_reset_password_token", :unique => true
  add_index "moderators", ["username"], :name => "index_moderators_on_username"

  create_table "nickname_records", :force => true do |t|
    t.integer  "person_id"
    t.string   "nickname"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nickname_records", ["nickname"], :name => "index_nickname_records_on_nickname"
  add_index "nickname_records", ["person_id", "nickname"], :name => "index_nickname_records_on_person_id_and_nickname", :unique => true
  add_index "nickname_records", ["person_id"], :name => "index_nickname_records_on_person_id"

  create_table "people", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dist",                                       :default => 0
    t.string   "name",                                       :default => "*"
    t.boolean  "gender",                                     :default => false
    t.string   "twitter",                                    :default => "*"
    t.string   "facebook",                                   :default => "*"
    t.string   "linkedin",                                   :default => "*"
    t.string   "wikipedia",                                  :default => "*"
    t.string   "tumblr",                                     :default => "*"
    t.decimal  "lat_avg",    :precision => 15, :scale => 10, :default => 0.0
    t.decimal  "lng_avg",    :precision => 15, :scale => 10, :default => 0.0
    t.date     "birthyear"
    t.date     "birthmonth"
    t.date     "birthday"
  end

  add_index "people", ["dist"], :name => "index_people_on_dist"
  add_index "people", ["facebook"], :name => "index_people_on_facebook"
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
  add_index "phone_records", ["person_id"], :name => "index_phone_records_on_person_id"
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

  create_table "state_records", :force => true do |t|
    t.integer  "person_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",      :default => 1
  end

  add_index "state_records", ["person_id", "state"], :name => "index_state_records_on_person_id_and_state", :unique => true
  add_index "state_records", ["person_id"], :name => "index_state_records_on_person_id"
  add_index "state_records", ["state"], :name => "index_state_records_on_state"

  create_table "tag_records", :force => true do |t|
    t.integer  "person_id"
    t.string   "tag"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_records", ["person_id", "tag"], :name => "index_tag_records_on_person_id_and_tag", :unique => true
  add_index "tag_records", ["person_id"], :name => "index_tag_records_on_person_id"
  add_index "tag_records", ["tag"], :name => "index_tag_records_on_tag"

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
