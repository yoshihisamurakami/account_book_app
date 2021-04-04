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

ActiveRecord::Schema.define(version: 2021_04_04_105526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.date "books_date"
    t.bigint "user_id"
    t.bigint "account_id"
    t.boolean "deposit"
    t.boolean "transfer"
    t.bigint "category_id"
    t.string "summary"
    t.integer "amount"
    t.boolean "common"
    t.boolean "business"
    t.boolean "special"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_books_on_account_id"
    t.index ["books_date", "updated_at"], name: "index_books_on_books_date_and_updated_at"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.integer "target_year"
    t.integer "target_month"
    t.integer "regular_income"
    t.integer "extra_income"
    t.integer "special_income"
    t.integer "tax_funding"
    t.integer "special_funding"
    t.integer "savings"
    t.integer "fixed_budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "is_tax"
    t.boolean "is_fixed"
    t.boolean "is_food"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
  end

  add_foreign_key "books", "accounts"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "users"
end
