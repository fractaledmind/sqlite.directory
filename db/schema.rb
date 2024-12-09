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

ActiveRecord::Schema[8.1].define(version: 2024_12_08_235622) do
  create_table "entries", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "repository_url"
    t.json "uses", default: []
    t.string "host"
    t.string "operating_system"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_entries_on_user_id"
    t.check_constraint "JSON_TYPE(uses) = 'array'", name: "entry_uses_is_array"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_agent", null: false
    t.string "ip_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "github_uid", null: false
    t.string "github_username", null: false
    t.string "twitter_username"
    t.index ["github_uid"], name: "index_users_on_github_uid", unique: true
    t.index ["github_username"], name: "index_users_on_github_username", unique: true
  end

  add_foreign_key "entries", "users"
  add_foreign_key "sessions", "users"
end
