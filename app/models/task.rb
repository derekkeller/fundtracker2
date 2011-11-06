class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :investor
  belongs_to :task_owner, :class_name => "User", :foreign_key => "task_owner_id"

end
