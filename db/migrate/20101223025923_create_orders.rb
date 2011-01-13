class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :state, :null => false
      t.boolean :shipped, :null => false, :default => false
      t.integer :buyer_billing_address_id
      t.integer :buyer_shipping_address_id, :null => false
      t.string :google_order_number
      t.integer :cards_amount, :null => false
      t.string :activation_string
      t.decimal :authorization_amount, :precision => 8, :scale => 2

      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :buyer_billing_address_id
    add_index :orders, :buyer_shipping_address_id
    add_index :orders, :google_order_number
  end

  def self.down
    drop_table :orders
  end
end
