class CreatePrivateBetas < ActiveRecord::Migration
  def self.up
    create_table :private_betas do |t|
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :private_betas
  end
end
