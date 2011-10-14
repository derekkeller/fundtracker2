class AddInvestmentAmountToInvestments < ActiveRecord::Migration
  def self.up
    add_column :investments, :investment_amount, :integer, :default => 0
  end

  def self.down
    remove_column :investments, :investment_amount
  end
end
