class Company < ActiveRecord::Base

  belongs_to :fund, :dependent => :destroy
  has_many :investments
  has_many :financials
  has_many :forecasts
  has_many :reports
  has_many :users

  def next_record(class_name, id_number)
    current_date = self.try(class_name).find(id_number).date
    return self.try(class_name).where("date > ?", current_date).first.id
  rescue
    nil    
  end

  def previous_record(class_name, id_number)
    current_date = self.try(class_name).find(id_number).date
    return self.try(class_name).where("date < ?", current_date).last.id
  rescue
    nil
  end

  def next_report(id_number)
    current_date = Report.find(id_number).period
    return Report.where("period > ?", current_date).first.id
  end

  def previous_report(id_number)
    current_date = Report.find(id_number).period
    return Report.where("period < ?", current_date).last.id
  end

  def investment_total
    self.investments.sum(:investment_amount)
  rescue
    0
  end
  
  def cash_runway
    self.current_financial(:cash_balance) / self.current_financial(:cash_burn).to_f rescue 0
  end

# // Current & First //

  def current_financial(item)
    financial = self.financials.order('period ASC').last
    financial.try(item)
  end

  def current_investment(item)
    investment = self.investments.order('date ASC').last
    investment.try(item)
  end

  def first_investment(item)
    investment = self.investments.order('date ASC').first
    investment.try(item)
  end

# // Annual //

  def annual_financial(year, item)
    starting = Date.civil(year)
    ending = starting.end_of_year
    self.financials.sum("#{item}", :conditions => ['period between ? AND ?', starting, ending])    
  end

  def annual_financial_avg(year, item)
    starting = Date.civil(year)
    ending = starting.end_of_year
    self.financials.average("#{item}", :conditions => ['period between ? AND ?', starting, ending])    
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

  def annual_expenses(year)
    total_expenses = []
    expense_items = [ :cogs,
                      :operating_expenses,
                      :sg_and_a,
                      :r_and_d,
                      :depreciation,
                      :amortization,
                      :interest_expense,
                      :other_expense,
                      :tax_expense ]

    starting = Date.civil(year)
    ending = starting.end_of_year    

    expense_items.each do |item|
      total_expenses << self.financials.sum("#{item}", :conditions => ['period between ? AND ?', starting, ending])
    end

    total_expenses.sum
  end

# // TTM //

  def ttm_expenses
    total_expenses = []
    expense_items = [ :cogs,
                      :operating_expenses,
                      :sg_and_a,
                      :r_and_d,
                      :depreciation,
                      :amortization,
                      :interest_expense,
                      :other_expense,
                      :tax_expense]
    
    ending = Date.today.months_ago(1).end_of_month                  
    starting = ending.years_ago(1) + 1
    
    expense_items.each do |item|
      total_expenses << self.financials.sum("#{item}", :conditions => ['period between ? AND ?', starting, ending])
    end  
    
    total_expenses.sum
    
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
  
# // Margins //

  def annual_operating_margin(year)
    starting = Date.civil(year)
    ending = starting.end_of_year    
    self.financials.sum(:cogs, :conditions => ['period between ? AND ?', starting, ending]) / annual_financial(year,:revenue).to_f
  end

  def annual_net_margin(year)
    starting = Date.civil(year)
    ending = starting.end_of_year
    (annual_financial(year,:revenue) - annual_expenses(year) + annual_revenue_other(year)) / annual_financial(year,:revenue).to_f
  end

end