class Company < ActiveRecord::Base

  belongs_to :fund
  has_many :investments, :order => 'date DESC'
  has_many :financials
  has_many :balances
  has_many :users
  
  
  def investment_total
    self.investments.inject(0.0) { |sum, s| sum += s.investment_amount }
  rescue
    0
  end
  
  def ownership_percentage
    self.investments.order('date DESC').last.fully_diluted_ownership
  rescue
    0    
  end

  def ttm_revenue
    #revenue from the past 12 months (financials)
    ending = Date.today.beginning_of_month - 1
    starting = ending.months_ago(12).end_of_month + 1
    ttm = self.financials.sum(:revenue, :conditions => ['period between ? AND ?', starting, ending])
  rescue
    0
  end

  def cash_runway
    #take most current cash balance, and divide by the most current cash/burn
    cash_balance = self.balances.order('period_end DESC').last.cash_balance
    cash_burn = self.balances.order('period_end DESC').last.cash_burn
    cash_balance / cash_burn    
  rescue
    0
  end
  
end