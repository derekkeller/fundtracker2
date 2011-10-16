# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111012191044) do

  create_table "companies", :force => true do |t|
    t.integer  "fund_id"
    t.string   "name"
    t.date     "founded"
    t.integer  "industry_id"
    t.text     "description"
    t.integer  "reserves"
    t.text     "syndicate"
    t.integer  "status_id"
    t.date     "status_date"
    t.integer  "exit_amount", :default => 0
    t.integer  "fund_return", :default => 0
    t.text     "notes"
    t.boolean  "active",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financials", :force => true do |t|
    t.integer  "company_id"
    t.integer  "bookings",           :default => 0
    t.integer  "revenue",            :default => 0
    t.integer  "cogs",               :default => 0
    t.integer  "operating_expenses"
    t.integer  "sg_and_a",           :default => 0
    t.integer  "r_and_d",            :default => 0
    t.integer  "depreciation",       :default => 0
    t.integer  "amortization",       :default => 0
    t.integer  "interest_income",    :default => 0
    t.integer  "interest_expense",   :default => 0
    t.integer  "other_income",       :default => 0
    t.integer  "other_expense",      :default => 0
    t.integer  "tax_expense",        :default => 0
    t.integer  "head_count"
    t.integer  "integer",            :default => 0
    t.integer  "debt_balance",       :default => 0
    t.integer  "cash_balance",       :default => 0
    t.integer  "cash_burn",          :default => 0
    t.date     "period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funds", :force => true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.string   "number"
    t.boolean  "aggregate",                                      :default => false
    t.decimal  "size",            :precision => 11, :scale => 2, :default => 0.0
    t.decimal  "management_fee",  :precision => 9,  :scale => 2, :default => 0.0
    t.date     "start_date"
    t.boolean  "active",                                         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "investments", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.integer  "existing_capital_raised",                                  :default => 0
    t.date     "date"
    t.integer  "investment_amount"
    t.integer  "pre_money",                                                :default => 0
    t.integer  "capital_raised",                                           :default => 0
    t.integer  "post_money",                                               :default => 0
    t.string   "security_type"
    t.decimal  "share_price",                :precision => 6, :scale => 2, :default => 0.0
    t.decimal  "liquidation_preference",     :precision => 6, :scale => 2, :default => 0.0
    t.decimal  "liquidation_preference_cap", :precision => 6, :scale => 2, :default => 0.0
    t.decimal  "dividend_rate",              :precision => 5, :scale => 2, :default => 0.0
    t.integer  "dividend_period"
    t.integer  "shares_purchased"
    t.decimal  "preferred_ownership",        :precision => 5, :scale => 2, :default => 0.0
    t.decimal  "fully_diluted_ownership",    :precision => 5, :scale => 2, :default => 0.0
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_hash"
    t.integer  "fund_id"
    t.integer  "role_id"
    t.boolean  "active",                   :default => false
    t.boolean  "is_admin",                 :default => false
    t.datetime "last_login"
    t.string   "password_recovery_hash"
    t.datetime "recovery_hash_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
