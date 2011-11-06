class Investor < ActiveRecord::Base

  belongs_to :organization
  has_many :users
  has_many :events
  has_many :tasks

end
