class RemoveShowEmail < ActiveRecord::Migration
  def self.up
    remove_column :users, :show_email
  end

  def self.down
  end
end
