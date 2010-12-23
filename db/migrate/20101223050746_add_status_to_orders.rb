class AddStatusToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :status, :string, :null => false, :default => "awaiting-activation"
  end

  def self.down
    remove_column :orders, :status
  end
end
