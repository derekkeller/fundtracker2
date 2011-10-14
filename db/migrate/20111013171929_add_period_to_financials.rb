class AddPeriodToFinancials < ActiveRecord::Migration
  def self.up
    add_column :financials, :period, :date
  end

  def self.down
    remove_column :financials, :period
  end
end
