class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :address1, :null => false
      t.string :address2
      t.string :city, :null => false
      t.string :company_name
      t.string :contact_name
      t.string :country_code, :null => false
      t.string :email
      t.string :fax
      t.string :phone
      t.string :postal_code, :null => false
      t.string :region, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end