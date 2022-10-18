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

ActiveRecord::Schema[7.0].define(version: 2022_10_18_054709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.string "user_name"
    t.bigint "event_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "address"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "pincode"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string "photo"
    t.bigint "event_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_photos_on_event_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id"
    t.integer "seasons"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "user_name"
    t.string "user_email"
    t.bigint "event_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_subscriptions_on_event_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vah_import_dat_line_errors", force: :cascade do |t|
    t.bigint "vah_import_dat_id"
    t.integer "line_number", null: false
    t.text "line", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vah_import_dat_id"], name: "index_vah_import_dat_line_errors_on_vah_import_dat_id"
  end

  create_table "vah_imports", force: :cascade do |t|
    t.text "type", null: false
    t.text "path", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.text "import_errors"
    t.boolean "successed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vah_met_sites", force: :cascade do |t|
    t.bigint "vah_met_id", null: false
    t.integer "site_number", null: false
    t.jsonb "frags_values", default: {}, null: false
    t.string "check_sum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vah_import_dat_id", null: false
    t.text "line_numbers", default: [], array: true
    t.index ["vah_met_id", "site_number", "check_sum"], name: "index_vah_met_sites_on_vah_met_id_and_site_number_and_check_sum", unique: true
    t.index ["vah_met_id"], name: "index_vah_met_sites_on_vah_met_id"
  end

  create_table "vah_mets", force: :cascade do |t|
    t.bigint "wafer_id"
    t.bigint "vah_norm_id"
    t.datetime "datetime"
    t.string "device"
    t.string "operator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "met_date"
    t.string "met_time"
    t.string "norm_name"
    t.boolean "sites_check_sums_count_error", default: false
    t.index ["vah_norm_id"], name: "index_vah_mets_on_vah_norm_id"
    t.index ["wafer_id", "datetime", "device"], name: "index_vah_mets_on_wafer_id_and_datetime_and_device", unique: true
    t.index ["wafer_id"], name: "index_vah_mets_on_wafer_id"
  end

  create_table "vah_norms", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_nors", default: false
    t.string "check_md5", null: false
    t.tsrange "range_date"
    t.datetime "start_time"
    t.integer "sites_count", default: 0, null: false
    t.integer "frags_count", default: 0, null: false
    t.integer "params_count", default: 0, null: false
    t.jsonb "frags_params", default: {}, null: false
    t.string "check_sum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "is_nors", "check_md5"], name: "index_vah_norms_on_name_and_is_nors_and_check_md5", unique: true
  end

  create_table "wafers", force: :cascade do |t|
    t.string "name"
    t.string "product"
    t.string "lot"
    t.string "lot_packet"
    t.string "lot_order"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "events"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "users"
  add_foreign_key "photos", "events"
  add_foreign_key "photos", "users"
  add_foreign_key "players", "teams"
  add_foreign_key "subscriptions", "events"
  add_foreign_key "subscriptions", "users"
end
