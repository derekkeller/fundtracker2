class Event < ActiveRecord::Base

  belongs_to :user
  belongs_to :investor

  has_many :participants
  has_many :attendees, :through => :participants, :source => :user

  accepts_nested_attributes_for :participants


  def attending_investors
    self.attendees.where('investor_id IS NOT null').all
  end
  

  def attending_managers
    self.attendees.where('organization_id IS NOT null').all    
  end

end
