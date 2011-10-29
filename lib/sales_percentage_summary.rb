class SalesPercentageSummary

  attr_accessor :company, :financial_set
  
  FinancialSet = Struct.new(:year,
                            :label,
                            :bookings,
                            :revenue,
                            :cogs,
                            :operating_expenses,
                            :sg_and_a,
                            :r_and_d,
                            :depreciation,
                            :amortization,
                            :interest_income,
                            :other_income,
                            :other_expense,
                            :tax_expense,
                            :head_count,
                            :debt_balance,
                            :cash_balance,
                            :cash_burn)


  def initialize(periods, company)
    @periods = periods
    @company = company
    @financial_set = []
    
    @periods.each do |p|
      financial_records = get_summary_data(@company, p)[0]
      
      begin
        @bookings             = financial_records['bookings'] / financial_records['revenue'].to_f
        @revenue              = financial_records['revenue'] / financial_records['revenue'].to_f
        @cogs                 = financial_records['cogs'] / financial_records['revenue'].to_f
        @operating_expenses   = financial_records['operating_expenses'] / financial_records['revenue'].to_f
        @sg_and_a             = 0        
        @r_and_d              = 0        
        @depreciation         = 0        
        @amortization         = 0
        @interest_income      = 0
        @other_income         = 0
        @other_expense        = 0
        @tax_expense          = 0
        @head_count           = 0
        @debt_balance         = 0
        @cash_balance         = 0
        @cash_burn            = 0
      rescue
        @bookings             = 0
        @revenue              = 0
        @cogs                 = 0        
        @operating_expenses   = 0
        @sg_and_a             = 0        
        @r_and_d              = 0        
        @depreciation         = 0        
        @amortization         = 0
        @interest_income      = 0
        @other_income         = 0
        @other_expense        = 0
        @tax_expense          = 0
        @head_count           = 0
        @debt_balance         = 0
        @cash_balance         = 0
        @cash_burn            = 0
      end

      @financial_set << FinancialSet.new(p.first.year,
                                          p,
                                          @bookings,
                                          @revenue,
                                          @cogs,
                                          @operating_expenses,
                                          @sg_and_a,
                                          @r_and_d,
                                          @depreciation,
                                          @amortization,
                                          @interest_income,
                                          @other_income,
                                          @other_expense,
                                          @tax_expense,
                                          @head_count,
                                          @debt_balance,
                                          @cash_balance,
                                          @cash_burn)
    end
  end
  
  def get_summary_data(company, period)
    Financial.connection.select_all("SELECT
                                      sum(bookings) bookings,
                                      sum(revenue) revenue,
                                      sum(cogs) cogs,
                                      sum(operating_expenses) operating_expenses
                                    FROM financials
                                    WHERE company_id=#{company.id} AND period between '#{period[0]}' AND '#{period[1]}'
                                    GROUP BY company_id")              
  end
end