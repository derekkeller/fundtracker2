class FinancialSummary

  attr_accessor :company, :financial_set


  FinancialSet = Struct.new(:bookings, :revenue, :cogs, :operating_expenses, :year)

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
      rescue
        @bookings             = 0
        @revenue              = 0
        @cogs                 = 0        
        @operating_expenses   = 0
      end
      
      @financial_set << FinancialSet.new(@bookings, @revenue, @cogs, @operating_expenses)
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