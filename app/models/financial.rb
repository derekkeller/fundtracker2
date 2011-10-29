class Financial < ActiveRecord::Base

  belongs_to :company, :dependent => :destroy

end
