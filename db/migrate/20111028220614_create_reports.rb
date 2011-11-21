class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :company_id
      t.date    :period
      t.text    :summary
      t.string  :summary_status
      t.text    :management
      t.string  :management_status
      t.text    :product
      t.string  :product_status
      t.text    :marketing
      t.string  :marketing_status
      t.text    :business_development
      t.string  :business_development_status
      t.text    :competition
      t.string  :competition_status
      t.text    :sales
      t.string  :sales_status
      t.text    :finance
      t.string  :finance_status
      t.text    :legal
      t.string  :legal_status
      t.text    :other
      t.string  :other_status      
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end