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

ActiveRecord::Schema.define(version: 20150923221809) do

  create_table "admins", primary_key: "user_name", force: :cascade do |t|
    t.string "name",        limit: 25, null: false
    t.string "password",    limit: 50, null: false
    t.string "email",       limit: 25, null: false
    t.string "primary_ind", limit: 1,  null: false
  end

  create_table "book_requests", force: :cascade do |t|
    t.string "isbn",        limit: 13, null: false
    t.string "title",       limit: 50, null: false
    t.string "author",      limit: 25, null: false
    t.string "description", limit: 50, null: false
    t.string "status",      limit: 12, null: false
  end

  create_table "books", primary_key: "isbn", force: :cascade do |t|
    t.string   "title",       limit: 50,                       null: false
    t.string   "authors",     limit: 25,                       null: false
    t.string   "description", limit: 50,                       null: false
    t.string   "status",      limit: 12, default: "Available", null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "checkout_details", id: false, force: :cascade do |t|
    t.string   "isbn",               limit: 13, null: false
    t.string   "user_name",          limit: 50, null: false
    t.datetime "checkout_date",                 null: false
    t.datetime "return_date"
    t.datetime "actual_return_date"
    t.string   "checkout_status",    limit: 10, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "requests", id: false, force: :cascade do |t|
    t.string "isbn",        limit: 13,               null: false
    t.string "user_name",   limit: 25,               null: false
    t.string "request_ind", limit: 1,  default: "Y", null: false
  end

  create_table "users", primary_key: "user_name", force: :cascade do |t|
    t.string   "name",       limit: 25,                    null: false
    t.string   "password",   limit: 50,                    null: false
    t.string   "email_id",   limit: 25,                    null: false
    t.string   "status",     limit: 10, default: "Active", null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

end
