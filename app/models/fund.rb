class Fund < ActiveRecord::Base

  belongs_to :organization
  has_many :companies, :order => "name"
  has_many :users
  has_many :investments, :through => :companies

  validates :name, :presence => true

end
