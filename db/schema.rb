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

ActiveRecord::Schema.define(version: 2022_12_16_083150) do

  create_table "bookings", force: :cascade do |t|
    t.string "booking_code", null: false
    t.integer "rental_store_id", null: false
    t.integer "return_store_id", null: false
    t.integer "car_id", null: false
    t.integer "user_id", null: false
    t.datetime "rental_start", null: false
    t.datetime "rental_end", null: false
    t.integer "total_price", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_bookings_on_car_id"
    t.index ["rental_store_id"], name: "index_bookings_on_rental_store_id"
    t.index ["return_store_id"], name: "index_bookings_on_return_store_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "car_code", null: false
    t.string "car_type", null: false
    t.integer "store_id", null: false
    t.string "name", null: false
    t.string "status", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_cars_on_store_id"
  end

  create_table "pricelists", force: :cascade do |t|
    t.integer "basic_price", null: false
    t.datetime "season_start"
    t.datetime "season_end"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "store_code", null: false
    t.string "name", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "adress", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "admin", default: false, null: false
    t.integer "sex", default: 1, null: false
    t.date "birthday"
    t.string "phone", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
