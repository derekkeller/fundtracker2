class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string    :name
      t.string    :event_type
      t.date      :date
      t.text      :notes
            
      t.integer   :investor_id
      t.integer   :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
