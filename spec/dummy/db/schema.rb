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

ActiveRecord::Schema[7.1].define(version: 2023_02_06_035622) do
  create_table "access_rules", force: :cascade do |t|
    t.string "principal_type", null: false
    t.integer "principal_id", null: false
    t.string "action", default: "deny", null: false
    t.datetime "created_at", null: false
    t.index ["principal_type", "principal_id"], name: "index_access_rules_on_principal", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "esi_alliances", force: :cascade do |t|
    t.integer "creator_corporation_id", null: false
    t.integer "creator_id", null: false
    t.date "date_founded", null: false
    t.string "esi_etag"
    t.datetime "esi_last_modified_at"
    t.datetime "esi_expires_at"
    t.integer "executor_corporation_id"
    t.integer "faction_id"
    t.string "name", null: false
    t.string "ticker", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticker"], name: "index_esi_alliances_on_ticker", unique: true
  end

  create_table "esi_characters", force: :cascade do |t|
    t.integer "alliance_id"
    t.integer "corporation_id", null: false
    t.date "birthday", null: false
    t.integer "bloodline_id", null: false
    t.text "description"
    t.string "esi_etag"
    t.datetime "esi_last_modified_at"
    t.datetime "esi_expires_at"
    t.integer "faction_id"
    t.string "gender", null: false
    t.string "name", null: false
    t.integer "race_id", null: false
    t.decimal "security_status"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_esi_characters_on_alliance_id"
    t.index ["corporation_id"], name: "index_esi_characters_on_corporation_id"
  end

  create_table "esi_corporations", force: :cascade do |t|
    t.integer "alliance_id"
    t.integer "ceo_id", null: false
    t.integer "creator_id", null: false
    t.date "date_founded", null: false
    t.text "description"
    t.string "esi_etag"
    t.datetime "esi_last_modified_at"
    t.datetime "esi_expires_at"
    t.integer "faction_id"
    t.integer "home_station_id"
    t.integer "member_count", null: false
    t.string "name", null: false
    t.bigint "shares"
    t.decimal "tax_rate", null: false
    t.string "ticker", null: false
    t.string "url"
    t.boolean "war_eligible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alliance_id"], name: "index_esi_corporations_on_alliance_id"
    t.index ["ticker"], name: "index_esi_corporations_on_ticker", unique: true
  end

  create_table "identities", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "character_id", null: false
    t.boolean "main"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "character_id"], name: "index_identities_on_account_id_and_character_id", unique: true
    t.index ["account_id", "main"], name: "index_identities_on_account_id_and_main", unique: true
  end

  add_foreign_key "esi_characters", "esi_alliances", column: "alliance_id"
  add_foreign_key "esi_characters", "esi_corporations", column: "corporation_id"
  add_foreign_key "esi_corporations", "esi_alliances", column: "alliance_id"
  add_foreign_key "identities", "accounts"
  add_foreign_key "identities", "esi_characters", column: "character_id"
end
