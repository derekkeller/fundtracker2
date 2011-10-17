class Fund < ActiveRecord::Base

  belongs_to :organization
  has_many :companies, :order => "name"
  has_many :users
  has_many :investments, :through => :companies

  validates :name, :presence => true

  def total_companies
    self.companies.count    
  end
  
  def invested_to_date
    invested = []
    Fund.first.companies.each do |comp|
      invested << comp.financials.sum(:investment_amount)
    end
    
    return invested.sum    
  end

end
