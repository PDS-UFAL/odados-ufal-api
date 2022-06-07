# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_07_185156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "form_sectors", force: :cascade do |t|
    t.bigint "sector_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "form_send_id"
    t.index ["sector_id"], name: "index_form_sectors_on_sector_id"
  end

  create_table "form_sends", force: :cascade do |t|
    t.datetime "end_date", null: false
    t.datetime "start_date", null: false
    t.integer "status", default: 1, null: false
    t.string "subtitle"
    t.bigint "form_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "year", default: 2022, null: false
    t.boolean "is_history"
    t.index ["form_id"], name: "index_form_sends_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.bigint "sector_ids", default: [], array: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.string "type", null: false
    t.boolean "required"
    t.integer "max_char"
    t.integer "max_value"
    t.integer "min_value"
    t.string "options", default: [], array: true
    t.bigint "section_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["section_id"], name: "index_questions_on_section_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "answer"
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fsend"
    t.bigint "sector_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["sector_id"], name: "index_responses_on_sector_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "form_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_sections_on_form_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "responsible"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "abbreviation"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sector_id"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.boolean "active", default: true, null: false
    t.string "name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sector_id"], name: "index_users_on_sector_id"
  end

  add_foreign_key "form_sectors", "sectors"
  add_foreign_key "form_sends", "forms"
  add_foreign_key "questions", "sections"
  add_foreign_key "responses", "questions"
  add_foreign_key "responses", "sectors"
  add_foreign_key "responses", "users"
  add_foreign_key "sections", "forms"
  add_foreign_key "users", "sectors"
end
