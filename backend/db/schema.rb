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

ActiveRecord::Schema.define(version: 2022_06_25_102356) do

  create_table "categories", charset: "utf8", force: :cascade do |t|
    t.bigint "type_id", null: false
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type_id"], name: "index_categories_on_type_id"
  end

  create_table "transactions", charset: "utf8", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.bigint "category_id", null: false
    t.text "description"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "types", charset: "utf8", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.text "name", null: false
    t.text "email", null: false
    t.text "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wallets", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "name"
    t.boolean "active"
    t.decimal "inFlow", precision: 10, scale: 2, default: "0.0"
    t.decimal "outFlow", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "categories", "types"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "wallets", "users"
end
