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

ActiveRecord::Schema.define(version: 2019_09_02_162958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chores", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "schedule"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_chores_on_site_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "notification_channels", force: :cascade do |t|
    t.string "channel_type"
    t.boolean "enabled"
    t.bigint "site_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_member_id"], name: "index_notification_channels_on_site_member_id"
  end

  create_table "scheduled_chores", force: :cascade do |t|
    t.datetime "due"
    t.bigint "chore_id"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chore_id"], name: "index_scheduled_chores_on_chore_id"
    t.index ["site_id"], name: "index_scheduled_chores_on_site_id"
  end

  create_table "site_members", force: :cascade do |t|
    t.string "nick_name"
    t.bigint "user_id"
    t.bigint "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "visitor", null: false
    t.string "status", default: "absent", null: false
    t.index ["site_id"], name: "index_site_members_on_site_id"
    t.index ["user_id", "site_id"], name: "index_site_members_on_user_id_and_site_id", unique: true
    t.index ["user_id"], name: "index_site_members_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone", default: "America/Chicago"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sys_admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chores", "sites"
  add_foreign_key "notification_channels", "site_members"
  add_foreign_key "scheduled_chores", "chores"
  add_foreign_key "scheduled_chores", "sites"
  add_foreign_key "site_members", "sites"
  add_foreign_key "site_members", "users"
end
