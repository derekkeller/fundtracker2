class CreateFinancials < ActiveRecord::Migration
  def self.up
    create_table :financials do |t|
      t.integer :company_id
      t.integer :bookings, :default => 0
      t.integer :revenue, :default => 0
      t.integer :cogs, :default => 0
      t.integer :operating_expenses
      t.integer :sg_and_a, :default => 0
      t.integer :r_and_d, :default => 0
      t.integer :depreciation, :default => 0
      t.integer :amortization, :default => 0
      t.integer :interest_income, :default => 0
      t.integer :interest_expense, :default => 0
      t.integer :other_income, :default => 0
      t.integer :other_expense, :default => 0
      t.integer :tax_expense, :default => 0
      t.integer :head_count, :integer
      t.integer :debt_balance, :integer, :default => 0
      t.integer :cash_balance, :integer, :default => 0    
      t.integer :cash_burn, :integer, :default => 0
      t.date    :period
      t.timestamps
    end
  end

  def self.down
    drop_table :financials
  end
end
