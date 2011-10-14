class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.integer :fund_id
      t.string  :name
      t.date    :founded
      t.integer :industry_id
      t.text    :description
      t.integer :reserves
      t.text    :syndicate
      t.integer :status_id
      t.date    :status_date
      t.integer :exit_amount, :default => 0
      t.integer :fund_return, :default => 0
      t.text    :notes
      t.boolean :active, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
