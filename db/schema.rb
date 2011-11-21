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

ActiveRecord::Schema.define(:version => 20111102184134) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "event_type"
    t.date     "date"
    t.text     "notes"
    t.integer  "investor_id"
    t.integer  "user_id"
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

  create_table "forecasts", :force => true do |t|
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

  create_table "investors", :force => true do |t|
    t.string   "name"
    t.string   "investor_type"
    t.integer  "organization_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "stage"
    t.text     "status"
    t.integer  "assets"
    t.integer  "expected_commitment"
    t.date     "expected_close"
    t.integer  "actual_commitment"
    t.integer  "actual_close"
    t.string   "probability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.string   "company_id"
    t.date     "period"
    t.text     "summary"
    t.string   "summary_status"
    t.text     "management"
    t.string   "management_status"
    t.text     "product"
    t.string   "product_status"
    t.text     "marketing"
    t.string   "marketing_status"
    t.text     "business_development"
    t.string   "business_development_status"
    t.text     "competition"
    t.string   "competition_status"
    t.text     "sales"
    t.string   "sales_status"
    t.text     "finance"
    t.string   "finance_status"
    t.text     "legal"
    t.string   "legal_status"
    t.text     "other"
    t.string   "other_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_users", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "due_date"
    t.boolean  "completed"
    t.date     "completed_date"
    t.integer  "task_owner_id"
    t.integer  "event_id"
    t.integer  "investor_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "company_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "notes"
    t.integer  "investor_id"
    t.string   "user_type"
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
