class Company < ActiveRecord::Base

  belongs_to :fund
  has_many :investments, :order => 'date ASC'
  has_many :financials
  has_many :balances
  has_many :users

  def investment_total
    self.investments.sum(:investment_amount)
  rescue
    0
  end
  
  def ownership_percentage
    self.investments.last.fully_diluted_ownership
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

    end2 = Date.today.months_ago(1).end_of_month
    end1 = end2.beginning_of_month

    beg2 = end2.years_ago(1).end_of_month
    beg1 = beg2.beginning_of_month
    
    beg_revenue = Company.last.financials.sum(:revenue, :conditions => ['period between ? AND ?', beg1, beg2])
    end_revenue = Company.last.financials.sum(:revenue, :conditions => ['period between ? AND ?', end1, end2])
    
    ((end_revenue.to_f / beg_revenue.to_f)**(1 / 12.to_f) - 1) * 100
  end
  
  def cash_runway
    #take most current cash balance, and divide by the most current cash/burn
    cash_balance = self.financials.order('period_end ASC').last.cash_balance
    cash_burn = self.financials.order('period_end ASC').last.cash_burn
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
    total_expenses = []
    expense_items = [ :cogs,
                      :operating_expenses,
                      :sg_and_a, :r_and_d,
                      :depreciation,
                      :amortization,
                      :interest_expense,
                      :other_expense,
                      :tax_expense ]

    starting = Date.civil(year)
    ending = starting.end_of_year    

    expense_items.each do |exp|
      total_expenses << self.financials.sum("#{exp}", :conditions => ['period between ? AND ?', starting, ending])
    end

    total_expenses.sum
  end

  def annual_revenue_other(year)
    starting = Date.civil(year)
    ending = starting.end_of_year

    revenue_other = []
    revenue_other_items = [ :other_income,
                            :interest_income ]
    revenue_other_items.each do |rev|
      revenue_other << self.financials.sum("#{rev}", :conditions => ['period between ? AND ?', starting, ending])
    end
    
    revenue_other.sum
  end

  def annual_operating_margin(year)
    starting = Date.civil(year)
    ending = starting.end_of_year    
    self.financials.sum(:cogs, :conditions => ['period between ? AND ?', starting, ending]) / annual_revenue(year).to_f
  end

  def annual_net_margin(year)
    starting = Date.civil(year)
    ending = starting.end_of_year
    
    (annual_revenue(year) - annual_expenses(year) + annual_revenue_other(year)) / annual_revenue(year).to_f    
  end

  def current_cash_balance
    self.financials.order('period ASC').last.cash_balance
  end
  
  def current_balance(item)
    self.financials.order('period ASC').last.("#{item}")
  end

end