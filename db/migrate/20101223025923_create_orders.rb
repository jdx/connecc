class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :type, :null => false
      t.integer :user_id, :null => false
      t.string :state, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :company_name, :null => false
      t.string :color, :null => false, :default => '#0248CD'
      t.string :address1, :null => false
      t.string :address2
      t.string :city, :null => false
      t.string :postal_code, :null => false
      t.string :region, :null => false
      t.boolean :charged, :null => false, :default => false
      t.boolean :shipped, :null => false, :default => false
      t.string :canceled
      t.decimal :authorization_amount, :precision => 8, :scale => 2, :null => false, :default => 0
      t.string :google_order_number

      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :google_order_number
  end

  def self.down
    drop_table :orders
  end
end
