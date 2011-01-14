class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.boolean :admin, :null => false, :default => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :time_zone, :null => false
      t.string :gender, :null => false, :limit => 1
      t.boolean :show_email, :null => false, :default => false
      t.string :phone_number
      t.string :twitter
      t.string :linkedin
      t.string :facebook
      t.string :web_site

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :first_name
    add_index :users, :last_name
  end

  def self.down
    drop_table :users
  end
end
