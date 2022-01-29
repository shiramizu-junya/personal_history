# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_26_050620) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id", null: false
    t.bigint "my_history_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_history_id"], name: "index_comments_on_my_history_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "age", null: false
    t.string "title", null: false
    t.text "episode", null: false
    t.integer "happiness", null: false
    t.bigint "my_history_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_history_id"], name: "index_events_on_my_history_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "my_history_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_history_id"], name: "index_likes_on_my_history_id"
    t.index ["user_id", "my_history_id"], name: "index_likes_on_user_id_and_my_history_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "my_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "uuid", null: false
    t.integer "status", default: 0, null: false
    t.string "title"
    t.string "graph_image"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_my_histories_on_user_id", unique: true
    t.index ["uuid"], name: "index_my_histories_on_uuid", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.date "birthday"
    t.integer "gender"
    t.string "avatar"
    t.string "crypted_password"
    t.string "salt"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "comments", "my_histories"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "my_histories"
  add_foreign_key "likes", "my_histories"
  add_foreign_key "likes", "users"
  add_foreign_key "my_histories", "users"
end
