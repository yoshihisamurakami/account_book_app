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

ActiveRecord::Schema.define(version: 20190216130651) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.date "books_date"
    t.integer "user_id"
    t.integer "account_id"
    t.boolean "deposit"
    t.boolean "transfer"
    t.integer "category_id"
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

end
