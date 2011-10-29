class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :company_id
      t.date    :period
      t.text    :summary
      t.integer  :summary_status
      t.text    :management
      t.integer  :management_status
      t.text    :product
      t.integer  :product_status
      t.text    :marketing
      t.integer  :marketing_status
      t.text    :business_development
      t.integer  :business_development_status
      t.text    :competition
      t.integer  :competition_status
      t.text    :sales
      t.integer  :sales_status
      t.text    :finance
      t.integer  :finance_status
      t.text    :legal
      t.integer  :legal_status
      t.text    :other
      t.integer  :other_status      
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end