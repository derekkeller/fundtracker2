class Company < ActiveRecord::Base

  belongs_to :fund
  has_many :investments, :order => 'date DESC'
  has_many :financials
  has_many :balances
  has_many :users

  def investment_total
    self.investments.sum(:investment_amount)
  rescue
    0
  end
  
  def ownership_percentage
    self.investments.order('date DESC').last.fully_diluted_ownership
  rescue
    0    
  end

  def ttm_revenue
    ending = Date.today.beginning_of_month - 1
    starting = ending.months_ago(12) + 1
    self.financials.sum(:revenue, :conditions => ['period between ? AND ?', starting, ending])
  rescue
    0
  end

  def ttm_revenue_previous
    ending = (Date.today.beginning_of_month - 1).months_ago(12)
    starting = ending.months_ago(12).end_of_month + 1
    self.financials.sum(:revenue, :conditions => ['period between ? AND ?', starting, ending])
  end

  def ttm_revenue_growth
    ((ttm_revenue.to_f - ttm_revenue_previous) / ttm_revenue_previous) * 100
  end

  def ttm_revenue_growth_monthly
  end
  
  def cash_runway
    #take most current cash balance, and divide by the most current cash/burn
    cash_balance = self.balances.order('period_end DESC').last.cash_balance
    cash_burn = self.balances.order('period_end DESC').last.cash_burn
    cash_balance / cash_burn    
  rescue
    0
  end

  def annual_bookings(year)
    starting = Date.civil(year)
    ending = starting.end_of_year
    self.financials.sum(:bookings, :conditions => ['period between ? AND ?', starting, ending])    
  end

  def annual_revenue(year)
    starting = Date.civil(year)
    ending = starting.end_of_year
    self.financials.sum(:revenue, :conditions => ['period between ? AND ?', starting, ending])    
  end

  def annual_cogs(year)
    starting = Date.civil(year)
    ending = starting.end_of_year
    self.financials.sum(:cogs, :conditions => ['period between ? AND ?', starting, ending])    
  end
  
  
  def annual_expenses(year)
    starting = Date.civil(year)
    ending = starting.end_of_year
    self.financials.sum(:cogs, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:operating_expenses, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:sg_and_a, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:r_and_d, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:depreciation, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:amortization, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:interest_expense, :conditions => ['period between ? AND ?', starting, ending])    
    self.financials.sum(:other_expense, :conditions => ['period between ? AND ?', starting, ending])                            
    self.financials.sum(:tax_expense, :conditions => ['period between ? AND ?', starting, ending])                            
  end

end