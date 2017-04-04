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

ActiveRecord::Schema.define(version: 20170404113817) do

  create_table "access_times", force: :cascade do |t|
    t.string   "name"
    t.datetime "from"
    t.datetime "to"
    t.integer  "duration_days"
    t.integer  "duration_hours"
    t.integer  "duration_minutes"
    t.integer  "break"
    t.boolean  "continuous_time_break"
    t.integer  "break_days"
    t.integer  "break_hours"
    t.integer  "break_minutes"
    t.integer  "staff_test_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["staff_test_id"], name: "index_access_times_on_staff_test_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string   "name"
    t.boolean  "correct"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_on_group_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "alt",               default: ""
    t.string   "hint",              default: ""
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "nomenclatures", force: :cascade do |t|
    t.integer  "nomenclature_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["nomenclature_id"], name: "index_nomenclatures_on_nomenclature_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "description"
    t.integer  "staff_test_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["staff_test_id"], name: "index_questions_on_staff_test_id"
  end

  create_table "staff_tests", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "structures", force: :cascade do |t|
    t.integer  "structure_id"
    t.string   "name"
    t.string   "address"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["structure_id"], name: "index_structures_on_structure_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id", "group_id"], name: "index_user_groups_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "username",           default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.string   "initials",           default: "", null: false
    t.integer  "role"
    t.integer  "structure_id"
    t.integer  "nomenclature_id"
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["nomenclature_id"], name: "index_users_on_nomenclature_id"
    t.index ["structure_id"], name: "index_users_on_structure_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
