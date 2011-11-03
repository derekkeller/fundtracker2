class CreateInvestors < ActiveRecord::Migration
  def self.up
    create_table :investors do |t|
      t.string    :name
      t.string    :investor_type
      t.integer   :organization_id

      t.string    :street
      t.string    :city
      t.string    :state
      t.integer   :zipcode
      t.integer   :stage
      t.text      :status
      t.integer   :stage
      t.integer   :assets
      t.integer   :expected_commitment
      t.date      :expected_close
      t.integer   :actual_commitment
      t.integer   :actual_close
      t.string    :probability
      t.timestamps
    end
  end

  def self.down
    drop_table :investors
  end
end