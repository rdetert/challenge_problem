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

ActiveRecord::Schema[7.0].define(version: 2022_02_26_224030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.bigint "player_id"
    t.string "device_model"
    t.integer "os"
    t.string "os_version", collation: "en_natural"
    t.integer "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_model"], name: "index_devices_on_device_model"
    t.index ["locale"], name: "index_devices_on_locale"
    t.index ["os"], name: "index_devices_on_os"
    t.index ["os_version"], name: "index_devices_on_os_version"
    t.index ["player_id"], name: "index_devices_on_player_id"
  end

  create_table "offer_targets", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "min_age"
    t.integer "max_age"
    t.integer "gender"
    t.integer "os"
    t.string "min_os_version", collation: "en_natural"
    t.integer "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender"], name: "index_offer_targets_on_gender"
    t.index ["locale"], name: "index_offer_targets_on_locale"
    t.index ["max_age"], name: "index_offer_targets_on_max_age"
    t.index ["min_age"], name: "index_offer_targets_on_min_age"
    t.index ["min_os_version"], name: "index_offer_targets_on_min_os_version"
    t.index ["offer_id"], name: "index_offer_targets_on_offer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.string "header"
    t.text "description"
    t.integer "points"
    t.decimal "payout", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthdate"
    t.integer "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["birthdate"], name: "index_players_on_birthdate"
    t.index ["gender"], name: "index_players_on_gender"
  end

end
