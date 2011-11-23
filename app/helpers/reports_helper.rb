module ReportsHelper

  def get_flag_color(item)
    case item
    when 'green'
      'flag_green'
    when 'yellow'
      'flag_yellow'
    when 'red'
      'flag_red' 
    else
      ''
    end
  end
  
  def report_move_back
    
    report_start = session[:report_year].years_ago(1).beginning_of_year
    report_end = session[:report_year].years_ago(1).end_of_year
    new_report = Report.where('period between ? AND ?', report_start, report_end).last

    if new_report      
      link_to "< #{session[:report_year].years_ago(1).year}", report_change_report_period_path(params[:id], :organization_id => params[:organization_id], :fund_id => params[:fund_id], :company_id => @company.id, :report_move_direction => 1), :method => :put    
    else  
      "< " + session[:report_year].years_ago(1).year.to_s
    end
  end


  def report_move_forward
    report_start = session[:report_year].years_since(1).beginning_of_year
    report_end = session[:report_year].years_since(1).end_of_year
    new_report = Report.where('period between ? AND ?', report_start, report_end).last

    if new_report      
      link_to "#{session[:report_year].years_since(1).year} >", report_change_report_period_path(params[:id], :organization_id => params[:organization_id], :fund_id => params[:fund_id], :company_id => @company.id), :method => :put    
    else  
      session[:report_year].years_since(1).year.to_s + " >"
    end
  end
  
end
