class User < ActiveRecord::Base

  scope :investors, joins(:assignments).where('assignments.role_id = 3')
  scope :employees, joins(:assignments).where('assignments.role_id in (1,2)')
  
  belongs_to :investor

  has_many :participants
  has_many :events, :through => :participants
  has_many :tasks
  has_many :assignments
  has_many :roles, :through => :assignments

  accepts_nested_attributes_for :participants

end
