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

ActiveRecord::Schema.define(version: 2018_08_05_210008) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.decimal "balance"
    t.integer "status"
    t.string "person_type"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_accounts_on_ancestry"
    t.index ["person_type", "person_id"], name: "index_accounts_on_person_type_and_person_id"
  end

  create_table "legal_people", force: :cascade do |t|
    t.string "cnpj"
    t.string "company_name"
    t.string "fantasy_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "physical_people", force: :cascade do |t|
    t.string "cpf"
    t.string "name"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "transaction_type"
    t.decimal "value"
    t.integer "origin_account_id"
    t.decimal "origin_account_before_transaction"
    t.integer "destination_account_id"
    t.decimal "destination_account_before_transaction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_account_id"], name: "index_transactions_on_destination_account_id"
    t.index ["origin_account_id"], name: "index_transactions_on_origin_account_id"
  end

end
