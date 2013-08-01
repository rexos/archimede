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

ActiveRecord::Schema.define(:version => 20130731162457) do

  create_table "addresses", :force => true do |t|
    t.string   "street"
    t.integer  "number"
    t.integer  "cap"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "bill_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bills", :force => true do |t|
    t.string   "business_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "cf"
    t.string   "iva"
    t.integer  "teacher_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "skills", :force => true do |t|
    t.integer  "teacher_id"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.string   "token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "skype"
    t.boolean  "skype_bool",        :default => false
    t.string   "cost"
    t.integer  "range"
    t.string   "availability_days"
    t.string   "info"
    t.boolean  "rating_bool",       :default => false
    t.integer  "rating"
    t.boolean  "time_bank_bool",    :default => false
    t.boolean  "bill_bool",         :default => false
    t.date     "deadline"
    t.boolean  "active",            :default => false
    t.string   "password_digest"
    t.string   "token"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

end
