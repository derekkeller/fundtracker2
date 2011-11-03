class ApplicationController < ActionController::Base
  protect_from_forgery

  def crement_period(crement, major = '0')
    case session[:view_period]
    when 'year'
      if crement == '1' 
        session[:crement_period] += 1.year
      else
        session[:crement_period] -= 1.year
      end
    when 'month'
      if major == '1'
        if crement == '1'
          session[:crement_period] += 1.year
        else
          session[:crement_period] -= 1.year
        end
      else
        if crement == '1'
          session[:crement_period] += 1.month
        else
          session[:crement_period] -= 1.month
        end
      end
    else
      if major == '1'
        if crement == '1'
          session[:crement_period] += 1.year
        else
          session[:crement_period] -= 1.year
        end
      else
        if crement == '1'
          session[:crement_period] = session[:crement_period].end_of_quarter + 1
        else
          session[:crement_period] = session[:crement_period].beginning_of_quarter - 1
        end
      end
    end          
  end

  def set_view_type(t)
    case t
    when '1'
      session[:view_type] = 'actual'
    when '2'
      session[:view_type] = 'forecast'
    when '3'
      session[:view_type] = 'variance'
    when '4'
      session[:view_type] = 'growth'
    when '5'
      session[:view_type] = 'sales'
    end    
  end

  def set_view_period(p)
    case p
    when '1'
      session[:view_period] = 'year'
    when '3'
      session[:view_period] = 'month'
    else
      session[:view_period] = 'quarter'
    end
  end

  def get_view_type
    session[:view_type] ||= 'actual'    
  end

  def get_view_period
    session[:view_period] ||= 'quarter'
  end

  def get_months(period)        
    months = []
    months[0] = [(period.beginning_of_month - 1).beginning_of_month, period.beginning_of_month - 1]
    11.times do
      months << [months.last[0].months_ago(1).beginning_of_month, months.last[1].months_ago(1).end_of_month]
    end
    return months.reverse
  end

  def get_quarters(period)
    q8 = period.beginning_of_quarter
    q7 = (q8 - 1).beginning_of_quarter
    q6 = (q7 - 1).beginning_of_quarter
    q5 = (q6 - 1).beginning_of_quarter
    q4 = (q5 - 1).beginning_of_quarter
    q3 = (q4 - 1).beginning_of_quarter
    q2 = (q3 - 1).beginning_of_quarter
    q1 = (q2 - 1).beginning_of_quarter
    
    [
      [q1, q1.end_of_quarter],
      [q2, q2.end_of_quarter],
      [q3, q3.end_of_quarter],
      [q4, q4.end_of_quarter],
      [q5, q5.end_of_quarter],      
      [q6, q6.end_of_quarter],
      [q7, q7.end_of_quarter],
      [q8, q8.end_of_quarter],
    ]
    
  end

  def get_years(period)    
    years = []
    years[0] = [period.beginning_of_year, period.end_of_year]
    3.times do
      years << [years.last[0].years_ago(1).beginning_of_year, years.last[1].years_ago(1).end_of_year]
    end
    return years.reverse
  end

  def get_month(period)
    month = [[period.months_ago(1).beginning_of_month, period.months_ago(1).end_of_month]]
  end

  def get_quarter(period)
    quarter = [[period.beginning_of_quarter, period.end_of_quarter]]    
  end
  
  def get_year(period)
    year = [[period.beginning_of_year, period.end_of_year]]    
  end

end
