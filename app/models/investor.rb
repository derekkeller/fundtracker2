class Investor < ActiveRecord::Base

  has_many :users
  has_many :events
  has_many :tasks

end
