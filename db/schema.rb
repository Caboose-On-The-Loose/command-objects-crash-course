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

ActiveRecord::Schema[7.0].define(version: 2022_05_21_190558) do
  create_table "moderation_ip_addresses", force: :cascade do |t|
    t.string "ip", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip"], name: "index_moderation_ip_addresses_on_ip", unique: true
  end

  create_table "moderation_logs", force: :cascade do |t|
    t.string "type", null: false
    t.integer "ip_address_id", null: false
    t.integer "user_agent_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.string "thing_type"
    t.integer "thing_id"
    t.index ["ip_address_id"], name: "index_moderation_logs_on_ip_address_id"
    t.index ["kind"], name: "index_moderation_logs_on_kind"
    t.index ["thing_id", "thing_type"], name: "index_moderation_logs_on_thing_id_and_thing_type"
    t.index ["type"], name: "index_moderation_logs_on_type"
    t.index ["user_agent_id"], name: "index_moderation_logs_on_user_agent_id"
    t.index ["user_id"], name: "index_moderation_logs_on_user_id"
  end

  create_table "moderation_user_agents", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_moderation_user_agents_on_name", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_replies_on_post_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["status"], name: "index_users_on_status"
  end

  add_foreign_key "moderation_logs", "moderation_ip_addresses", column: "ip_address_id"
  add_foreign_key "moderation_logs", "moderation_user_agents", column: "user_agent_id"
  add_foreign_key "moderation_logs", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "replies", "posts"
  add_foreign_key "replies", "users"
end
