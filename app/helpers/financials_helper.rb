module FinancialsHelper

  def what_quarter(d)
    if (1..3).include?(d.month)
      "Q1 #{d.year}"
    elsif (4..6).include?(d.month)
      "Q2 #{d.year}"
    elsif (7..9).include?(d.month)
      "Q3 #{d.year}"
    else
      "Q4 #{d.year}"
    end    
  end

  def check_view(a, b)
    if a == b
      'bold'
    else
      ''
    end    
  end
  
  # check params for what kind of view we're in (actual, forecast) and make the current bold

end
