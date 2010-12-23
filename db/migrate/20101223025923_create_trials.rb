class CreateTrials < ActiveRecord::Migration
  def self.up
    create_table :trials do |t|
      t.integer :user_id, :null => false
      t.datetime :placed_at, :null => false
      t.datetime :activated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :trials
  end
end
