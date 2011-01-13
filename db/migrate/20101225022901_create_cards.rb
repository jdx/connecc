class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :code, :null => false
      t.integer :order_id, :null => false
      t.integer :user_id
      t.text :message
      t.boolean :visited, :null => false, :default => false

      t.timestamps
    end
    add_index :cards, :code
    add_index :cards, :order_id
  end

  def self.down
    drop_table :cards
  end
end
