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

ActiveRecord::Schema.define(version: 20170226205307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "messages", force: :cascade do |t|
    t.integer  "author_id",  null: false
    t.string   "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_messages_on_author_id", using: :btree
  end

  create_table "password_resets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer  "user_id"
    t.string   "status",     default: "pending", null: false
    t.string   "email",                          null: false
    t.inet     "ip"
    t.inet     "remote_ip"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["id"], name: "index_password_resets_on_id", unique: true, using: :btree
    t.index ["status"], name: "index_password_resets_on_status", using: :btree
    t.index ["user_id", "status"], name: "index_password_resets_on_user_id_and_status", unique: true, where: "((status)::text = 'pending'::text)", using: :btree
    t.index ["user_id"], name: "index_password_resets_on_user_id", using: :btree
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.inet     "ip"
    t.inet     "remote_ip"
    t.boolean  "active",     default: true, null: false
    t.datetime "expires_at",                null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["active"], name: "index_sessions_on_active", using: :btree
    t.index ["id"], name: "index_sessions_on_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "display_name",    null: false
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["display_name"], name: "index_users_on_display_name", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "messages", "users", column: "author_id", on_delete: :cascade
  add_foreign_key "password_resets", "users", on_delete: :cascade
  add_foreign_key "sessions", "users", on_delete: :cascade
end
