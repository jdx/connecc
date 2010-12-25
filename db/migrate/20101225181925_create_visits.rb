class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :card_id, :null => false
      t.string :ip_address, :null => false
      t.integer :count, :null => false, :default => 1
      t.integer :user_id

      t.timestamps
    end

    add_index :visits, :card_id
    add_index :visits, :ip_address
    add_index :visits, :user_id
    add_index :visits, :updated_at
  end

  def self.down
    drop_table :visits
  end
end
