class CreateContactRequests < ActiveRecord::Migration
  def self.up
    create_table :contact_requests do |t|
      t.integer :card_id, :null => false
      t.string :contact_info, :null => false
      t.string :text, :null => false
      t.string :ip_address, :null => false
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_requests
  end
end
