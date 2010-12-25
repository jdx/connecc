class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id, :null => false
      t.string :type, :null => false
      t.integer :cards_amount, :null => false
      t.datetime :placed_at, :null => false
      t.datetime :generated_at
      t.datetime :shipped_at
      t.string :status, :null => false
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :zip, :null => false

      t.timestamps
    end

    add_index :orders, :user_id
  end

  def self.down
    drop_table :orders
  end
end
