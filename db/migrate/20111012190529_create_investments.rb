class CreateInvestments < ActiveRecord::Migration
  def self.up
    create_table :investments do |t|
      t.integer :company_id
      t.string  :name
      t.decimal :existing_capital_raised, :precision => 11, :scale => 2, :default => 0.00
      t.date    :date
      t.integer :pre_money, :default => 0
      t.integer :capital_raised, :default => 0
      t.integer :post_money, :default => 0
      t.string  :security_type
      t.decimal :share_price, :precision => 6, :scale => 2, :default => 0.00
      t.decimal :liquidation_preference, :precision => 6, :scale => 2, :default => 0.00
      t.decimal :liquidation_preference_cap, :precision => 6, :scale => 2, :default => 0.00
      t.decimal :dividend_rate, :precision => 5, :scale => 2, :default => 0.00
      t.integer :dividends_period
      t.integer :shares_purchased
      t.decimal :preferred_ownership, :precision => 5, :scale => 2, :default => 0.00
      t.decimal :fully_diluted_ownership, :precision => 5, :scale => 2, :default => 0.00
      t.text    :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :investments
  end
end
