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

ActiveRecord::Schema.define(:version => 20120817013654) do

  create_table "experiments", :force => true do |t|
    t.string   "name"
    t.string   "action1"
    t.string   "action2"
    t.string   "outcome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_card_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "stripe_customer_token"
    t.string   "email"
    t.boolean  "trial",                 :default => false, :null => false
    t.string   "customer_id"
    t.boolean  "disabled",              :default => false, :null => false
  end

  add_index "subscriptions", ["email"], :name => "index_subscriptions_on_email", :unique => true

  create_table "trials", :force => true do |t|
    t.integer  "experiment_id"
    t.boolean  "should_do_action1",                    :null => false
    t.boolean  "outcome_good"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "borked",            :default => false, :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "subscription_id"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
