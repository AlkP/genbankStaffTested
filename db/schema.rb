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

ActiveRecord::Schema.define(version: 20170222063721) do

  create_table "groups", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_on_group_id"
  end

  create_table "nomenclatures", force: :cascade do |t|
    t.integer  "nomenclature_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["nomenclature_id"], name: "index_nomenclatures_on_nomenclature_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.string   "username",           default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.string   "initials",           default: "", null: false
    t.integer  "structure_id"
    t.integer  "nomenclature_id"
    t.integer  "role_id"
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["nomenclature_id"], name: "index_users_on_nomenclature_id"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["structure_id"], name: "index_users_on_structure_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
