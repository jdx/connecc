class CreateContactRequests < ActiveRecord::Migration
  def self.up
    create_table :contact_requests do |t|
      t.integer :card_id, :null => false
      t.string :email, :null => false
      t.text :message, :null => false
      t.string :ip_address, :null => false
      t.integer :user_id
      t.boolean :send_me_a_copy, :null => false, :default => false

      t.timestamps
    end

    add_index :contact_requests, :card_id
    add_index :contact_requests, :user_id
  end

  def self.down
    drop_table :contact_requests
  end
end
