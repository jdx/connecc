class AddUserInfo < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :null => false, :default => "First"
    add_column :users, :last_name, :string, :null => false, :default => "Last"
    add_column :users, :address_1, :string, :null => false, :default => "123 Example St"
    add_column :users, :address_2, :string
    add_column :users, :zip_code, :string, :null => false, :default => "97333"
    add_column :users, :city, :string, :null => false, :default => "Corvallis"
    add_column :users, :state, :string, :null => false, :default => "OR"
    add_column :users, :phone_number, :string, :null => false, :default => "871-718-7271"

    change_column :users, :first_name, :string, :null => false
    change_column :users, :last_name, :string, :null => false
    change_column :users, :address_1, :string, :null => false
    change_column :users, :zip_code, :string, :null => false
    change_column :users, :city, :string, :null => false
    change_column :users, :state, :string, :null => false
    change_column :users, :phone_number, :string, :null => false
  end

  def self.down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address_1
    remove_column :users, :address_2
    remove_column :users, :zip_code
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :phone_number
  end
end
