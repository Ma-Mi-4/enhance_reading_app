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

ActiveRecord::Schema[7.1].define(version: 2025_12_01_033228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "body", null: false
    t.boolean "correct", default: false
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "enabled", default: true, null: false
    t.time "notify_time", default: "2000-01-01 09:00:00", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notify_time"], name: "index_notification_settings_on_notify_time"
    t.index ["user_id"], name: "index_notification_settings_on_user_id"
  end

  create_table "question_sets", force: :cascade do |t|
    t.integer "level"
    t.string "title"
    t.string "category"
    t.text "content"
    t.integer "word_count"
    t.string "source"
    t.jsonb "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "filename"
    t.index ["filename"], name: "index_question_sets_on_filename", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "content"
    t.string "kind"
    t.string "category", default: "email", null: false
    t.integer "word_count", default: 0, null: false
    t.string "source"
    t.jsonb "meta", default: {}
    t.bigint "question_set_id"
    t.jsonb "choices_text"
    t.integer "correct_index"
    t.text "explanation"
    t.jsonb "wrong_explanations"
    t.integer "order"
    t.index ["question_set_id"], name: "index_questions_on_question_set_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.bigint "quiz_set_id", null: false
    t.string "word"
    t.string "question_text"
    t.jsonb "choices_text"
    t.integer "correct_index"
    t.string "example_sentence"
    t.text "explanation"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_set_id"], name: "index_quiz_questions_on_quiz_set_id"
  end

  create_table "quiz_sets", force: :cascade do |t|
    t.integer "level"
    t.string "title"
    t.jsonb "meta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_set_id"
    t.string "filename"
    t.index ["filename"], name: "index_quiz_sets_on_filename", unique: true
    t.index ["question_set_id"], name: "index_quiz_sets_on_question_set_id"
  end

  create_table "study_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date"
    t.integer "accuracy"
    t.integer "predicted_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minutes"
    t.integer "duration"
    t.integer "correct_total"
    t.integer "question_total"
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
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "crypted_password"
    t.string "salt"
    t.boolean "admin", default: false, null: false
    t.integer "level"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "questions", "question_sets"
  add_foreign_key "quiz_questions", "quiz_sets"
  add_foreign_key "quiz_sets", "question_sets"
  add_foreign_key "study_records", "users"
  add_foreign_key "study_times", "users"
end
