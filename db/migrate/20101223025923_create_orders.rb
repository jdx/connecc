class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id, :null => false
      t.boolean :trial, :null => false
      t.datetime :placed_at, :null => false
      t.datetime :activated_at
      t.string :status, :null => false

      t.timestamps
    end

    add_index :orders, :user_id
  end

  def self.down
    drop_table :orders
  end
end
