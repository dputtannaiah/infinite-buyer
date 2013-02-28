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

ActiveRecord::Schema.define(:version => 20120909172215) do

  create_table "accounts", :force => true do |t|
    t.string   "first_name",                    :null => false
    t.string   "last_name",                     :null => false
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip",              :limit => 5, :null => false
    t.integer  "search_radius",                 :null => false
    t.integer  "user_id",                       :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "company"
    t.string   "apt_suite_others"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "type"
    t.string   "paypal_email"
  end

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "admins", ["authentication_token"], :name => "index_admins_on_authentication_token", :unique => true
  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "bids", :force => true do |t|
    t.integer  "offer_id"
    t.integer  "user_id"
    t.decimal  "price",      :precision => 9, :scale => 2
    t.datetime "expires_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.decimal  "shipping",   :precision => 9, :scale => 2
    t.boolean  "bid_type"
  end

  create_table "blog_comments", :force => true do |t|
    t.text     "body"
    t.integer  "post_id"
    t.string   "name"
    t.string   "website"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "admin_id"
    t.datetime "reviewed_at"
  end

  create_table "blog_posts", :force => true do |t|
    t.integer  "admin_id"
    t.text     "body"
    t.string   "title"
    t.integer  "views",      :default => 0
    t.datetime "deleted_at"
    t.string   "avatar"
    t.string   "slug"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "ancestry"
    t.integer  "category_type", :limit => 2, :default => 0
    t.datetime "deleted_at"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"

  create_table "declined_offers", :force => true do |t|
    t.integer  "offer_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "keywords", :force => true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "negative_text"
    t.integer  "category_id"
    t.boolean  "status",        :default => true
  end

  create_table "offers", :force => true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.decimal  "price",                              :precision => 9, :scale => 2
    t.integer  "search_radius"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expire_at"
    t.string   "status",               :limit => 10
    t.datetime "canceled_at"
    t.datetime "fullfilled_at"
    t.datetime "expired_at"
    t.integer  "offer_type",                                                       :default => 0
    t.boolean  "expiry_email_sent_48",                                             :default => false
    t.boolean  "expiry_email_sent_24",                                             :default => false
  end

  create_table "photos", :force => true do |t|
    t.string   "image"
    t.integer  "bid_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "brand"
    t.string   "model"
    t.string   "color"
    t.text     "product_details"
    t.text     "technical_details"
    t.integer  "bid_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "purchases", :force => true do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "bid_id"
    t.text     "params"
    t.datetime "purchased_at"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.text     "ipn_notification_params"
  end

  create_table "seller_categories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "seller_offers", :force => true do |t|
    t.integer  "offer_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.text     "brief_description"
    t.text     "detailed_description"
    t.text     "additional_info"
    t.integer  "bid_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "key_name"
    t.string   "key_value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "super_admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "super_admins", ["authentication_token"], :name => "index_super_admins_on_authentication_token", :unique => true
  add_index "super_admins", ["confirmation_token"], :name => "index_super_admins_on_confirmation_token", :unique => true
  add_index "super_admins", ["email"], :name => "index_super_admins_on_email", :unique => true
  add_index "super_admins", ["reset_password_token"], :name => "index_super_admins_on_reset_password_token", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "username"
    t.integer  "logged_in_as"
    t.string   "twitter_id"
    t.string   "facebook_id"
    t.boolean  "delta",                  :default => true, :null => false
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
