class Organization < ActiveRecord::Base
  
  has_many :users
  has_many :investors
  has_many :funds
  has_many :companies, :through => :funds, :source => :companies

end
