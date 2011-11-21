class Report < ActiveRecord::Base
  belongs_to :company

  STATUS = [ 'green', 'yellow', 'red' ]

end
