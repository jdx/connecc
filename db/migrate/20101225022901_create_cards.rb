class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :code, :null => false
      t.integer :order_id, :null => false
      t.string :message

      t.timestamps
    end
    add_index :cards, :code
  end

  def self.down
    drop_table :cards
  end
end
