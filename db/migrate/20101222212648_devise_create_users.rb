class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.trackable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.boolean :admin, :null => false, :default => false
      t.string :name, :null => false
      t.boolean :show_email, :null => false, :default => true
      t.string :phone_number

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :name
  end

  def self.down
    drop_table :users
  end
end
