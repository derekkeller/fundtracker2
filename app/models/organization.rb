class Organization < ActiveRecord::Base
  
  has_many :funds
  has_many :companies, :through => :funds, :source => :companies

end
