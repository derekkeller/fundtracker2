class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer     :organization_id
      t.integer     :investor_id
      t.integer     :company_id

      t.string      :email
      t.string      :first_name
      t.string      :last_name
      t.text        :notes
      t.string      :user_type
      t.string      :password_hash
      t.integer     :role_id
      t.boolean     :active, :default => false
      t.boolean     :is_admin, :default => false
      t.datetime    :last_login
      t.string      :password_recovery_hash
      t.datetime    :recovery_hash_created_at
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
