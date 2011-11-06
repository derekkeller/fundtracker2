class Role < ActiveRecord::Base

  has_many :assignments
  has_many :users, :through => :assignments

  def self.admin
    find_by_name("admin")
  end   

  def self.manager
    find_by_name("manager")
  end

  def self.investor
    find_by_name("investor")
  end


end
