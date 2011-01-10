class CreateNotificationRequests < ActiveRecord::Migration
  def self.up
    create_table :notification_requests do |t|
      t.integer :card_id, :null => false
      t.string :email, :null => false
      t.string :ip_address, :null => false
      t.integer :user_id

      t.timestamps
    end

    add_index :notification_requests, :card_id
    add_index :notification_requests, :user_id
  end

  def self.down
    drop_table :notification_requests
  end
end
