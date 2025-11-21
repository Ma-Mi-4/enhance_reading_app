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

ActiveRecord::Schema[7.1].define(version: 2025_11_21_022047) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notification_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "enabled"
    t.time "notify_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_settings_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "content"
    t.string "kind"
  end

  create_table "study_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.integer "accuracy"
    t.integer "estimated_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minutes"
    t.integer "duration"
    t.index ["user_id"], name: "index_study_records_on_user_id"
  end

  create_table "study_times", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "question_id"
    t.integer "seconds"
    t.boolean "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_study_times_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "crypted_password"
    t.string "salt"
    t.string "password_digest"
    t.boolean "admin", default: false, null: false
    t.integer "level"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "notification_settings", "users"
  add_foreign_key "study_records", "users"
  add_foreign_key "study_times", "users"
end
