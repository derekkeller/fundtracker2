module FinancialsHelper

  def what_quarters(p)
    if (1..3).include?(p.month)
      "Q1 #{p.year}"
    elsif (4..6).include?(p.month)
      "Q2 #{p.year}"
    elsif (7..9).include?(p.month)
      "Q3 #{p.year}"
    else
      "Q4 #{p.year}"
    end
  end

end
