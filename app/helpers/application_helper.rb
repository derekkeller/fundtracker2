module ApplicationHelper

  def current_user
    @current_user ||= User.find_by_auth_token(session[:auth_token]) if session[:auth_token]
  end

  def nh(number, decimals=0)
    number_to_currency(number, :precision => decimals)    
  end

  def nhp(number, decimals=0)
    number_with_precision(number, :precision => decimals)
  end

  def nhelper(number, decimals=0)
    if session[:view_type] == 'sales'
      a = number_to_percentage(number * 100, :precision => 1)
      b = a == 'NaN%' ? '0%' : a
    else
      number_to_currency(number, :precision => decimals)
    end
  end

  def nhd(number)
    number_with_delimiter(number, :delimiter => ',')
  end

  def ph(n, p=0)
    a = number_to_percentage(n, :precision => p)
    b = a == 'NaN%' ? '0%' : a
  end

  def available_funds(o)
    o.funds.map {|f| [f.name, f.id]}.unshift(['All Funds',''])
  rescue
    Fund.all.map {|f| [f.name, f.id]}.unshift(['All Funds',''])
  end
  
  def available_companies(o)
    o.companies.map { |c| [c.name, c.id]}.unshift(['All Companies',''])
  rescue
    Company.all.map { |c| [c.name, c.id]}.unshift(['All Companies',''])
  end

  def check_view(a, b)
    if a == b
      'month_selected'
    else
      'month_plain'
    end    
  end
  
  # check params for what kind of view we're in (actual, forecast) and make the current bold

  def check_report(a, b)
    if (a - 1) == b
      'month_selected'
    else
      'month_plain'
    end    
  end

  def check_investment(a, b)
    if (a - 1) == b
      'month_selected'
    else
      'month_plain'
    end    
  end

end
