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

ActiveRecord::Schema[7.0].define(version: 2023_07_25_064449) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.string "key"
    t.bigint "video_id"
    t.index ["video_id"], name: "index_achievements_on_video_id"
  end

  create_table "api_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "path", null: false
    t.string "method", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.index ["user_id"], name: "index_api_requests_on_user_id"
  end

  create_table "api_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "token", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "plannings", force: :cascade do |t|
    t.string "name"
    t.string "planning_type"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_plannings_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shift_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shift_id"], name: "index_reservations_on_shift_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "planning_id", null: false
    t.string "day"
    t.time "start_hour"
    t.time "end_hour"
    t.integer "seats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seats_taken"
    t.index ["planning_id"], name: "index_shifts_on_planning_id"
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "achievement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "seen", default: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "user_videos", force: :cascade do |t|
    t.bigint "video_id", null: false
    t.bigint "user_id", null: false
    t.boolean "is_complete", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_seen", default: false
    t.index ["user_id"], name: "index_user_videos_on_user_id"
    t.index ["video_id"], name: "index_user_videos_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.boolean "added_to_list", default: false
    t.boolean "is_onboarded", default: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unlocked_by"
    t.bigint "next_video_id"
    t.bigint "previous_video_id"
    t.integer "achievements_count"
    t.index ["next_video_id"], name: "index_videos_on_next_video_id"
    t.index ["previous_video_id"], name: "index_videos_on_previous_video_id"
  end

  add_foreign_key "achievements", "videos"
  add_foreign_key "api_requests", "users"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "plannings", "users"
  add_foreign_key "reservations", "shifts"
  add_foreign_key "reservations", "users"
  add_foreign_key "shifts", "plannings"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "user_videos", "users"
  add_foreign_key "user_videos", "videos"
  add_foreign_key "videos", "videos", column: "next_video_id"
  add_foreign_key "videos", "videos", column: "previous_video_id"
end
