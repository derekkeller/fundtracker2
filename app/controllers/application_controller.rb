class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_period_type(p)
    case p
    when '1'
      session[:view_by] = 'year'
    when '3'
      session[:view_by] = 'month'
    else
      session[:view_by] = 'quarter'
    end
  end

  def get_view_by
    session[:view_by] ||= 'quarter'    
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
    q4 = period.beginning_of_quarter
    q3 = (q4 - 1).beginning_of_quarter
    q2 = (q3 - 1).beginning_of_quarter
    q1 = (q2 - 1).beginning_of_quarter
    
    [
      [q1, q1.end_of_quarter],
      [q2, q2.end_of_quarter],
      [q3, q3.end_of_quarter],
      [q4, q4.end_of_quarter]
    ]
  end

  def get_years(period)    
    years = []
    years[0] = [period.beginning_of_year, period.end_of_year]
    2.times do
      years << [years.last[0].years_ago(1).beginning_of_year, years.last[1].years_ago(1).end_of_year]
    end
    return years.reverse
  end

end
