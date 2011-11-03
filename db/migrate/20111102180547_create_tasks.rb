class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string      :name
      t.text        :description
      t.date        :due_date
      t.boolean     :completed
      t.date        :completed_date

      t.integer     :task_owner_id
      t.integer     :event_id
      t.integer     :investor_id
      t.integer     :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
