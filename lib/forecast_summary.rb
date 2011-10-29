class ForecastSummary

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
        @bookings             = financial_records['bookings'] || 0
        @revenue              = financial_records['revenue'] || 0
        @cogs                 = financial_records['cogs']
        @operating_expenses   = financial_records['operating_expenses'] || 0
        @sg_and_a             = financial_records['sg_and_a'] || 0
        @r_and_d              = financial_records['r_and_d'] || 0
        @depreciation         = financial_records['depreciation'] || 0
        @amortization         = financial_records['amortization'] || 0        
        @interest_income      = financial_records['interest_income'] || 0        
        @other_income         = financial_records['other_income'] || 0        
        @other_expense        = financial_records['other_expense'] || 0        
        @tax_expense          = financial_records['tax_expense'] || 0        
        @head_count           = financial_records['head_count'] || 0        
        @debt_balance         = financial_records['debt_balance'] || 0        
        @cash_balance         = financial_records['cash_balance'] || 0        
        @cash_burn            = financial_records['cash_burn'] || 0        
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
    Forecast.connection.select_all("SELECT
                                      sum(bookings) bookings,
                                      sum(revenue) revenue,
                                      sum(cogs) cogs,
                                      sum(operating_expenses) operating_expenses,
                                      sum(sg_and_a) sg_and_a, 
                                      sum(r_and_d) r_and_d, 
                                      sum(depreciation) depreciation, 
                                      sum(amortization) amortization, 
                                      sum(interest_income) interest_income, 
                                      sum(other_income) other_income, 
                                      sum(other_expense) other_expense, 
                                      sum(tax_expense) tax_expense                                      
                                    FROM forecasts
                                    WHERE company_id=#{company.id} AND period between '#{period[0]}' AND '#{period[1]}'
                                    GROUP BY company_id")    
  end

end