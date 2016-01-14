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

ActiveRecord::Schema.define(version: 20160114074453) do

  create_table "chapters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.integer  "index"
    t.integer  "note_id"
  end

  add_index "chapters", ["note_id"], name: "index_chapters_on_note_id"

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "text"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "title"
    t.integer  "viewby"
    t.integer  "follower"
    t.string   "description_padId"
    t.integer  "user_id"
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id"

  create_table "pads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url"
  end

  create_table "questions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "padId"
    t.string   "pad_url"
    t.integer  "section_id"
  end

  add_index "questions", ["section_id"], name: "index_questions_on_section_id"

  create_table "sections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "padId"
    t.string   "title"
    t.integer  "index"
    t.integer  "chapter_id"
  end

  add_index "sections", ["chapter_id"], name: "index_sections_on_chapter_id"

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "link"
    t.string   "gender"
    t.string   "image"
    t.string   "email"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.string   "provider"
  end

  create_table "users_sections_likes", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "section_id"
  end

end
