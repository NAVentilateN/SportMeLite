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

ActiveRecord::Schema.define(version: 2021_12_01_114241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coach_profiles", force: :cascade do |t|
    t.date "coach_start_date"
    t.text "description"
    t.bigint "sport_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sport_id"], name: "index_coach_profiles_on_sport_id"
    t.index ["user_id"], name: "index_coach_profiles_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string "location"
    t.integer "price"
    t.boolean "status"
    t.integer "student_id"
    t.bigint "coach_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_lessons_on_coach_id"
    t.index ["student_id"], name: "index_lessons_on_student_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.date "date_of_birth"
    t.string "contact_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coach_profiles", "sports"
  add_foreign_key "coach_profiles", "users"
  add_foreign_key "lessons", "users", column: "coach_id"
  add_foreign_key "lessons", "users", column: "student_id"
end
