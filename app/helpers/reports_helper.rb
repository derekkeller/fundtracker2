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

end
