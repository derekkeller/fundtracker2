module ApplicationHelper

  def nh(number, decimals=0)
    number_to_currency(number, :precision => decimals)    
  end

  def ph(n, p=0)
    a = number_to_percentage(n, :precision => p)
    b = a == 'NaN%' ? '0%' : a
  end

end
