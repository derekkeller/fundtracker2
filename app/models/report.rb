class Report < ActiveRecord::Base
  belongs_to :company

  STATUS = { 0 => 'Green', 1 => 'Yellow', 2 => 'Red' }
end
