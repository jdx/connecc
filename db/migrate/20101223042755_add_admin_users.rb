class AddAdminUsers < ActiveRecord::Migration
  def self.up
    user = User.new( :email => "jeff@conne.cc", :password => "password", :password_confirm => "password" )
    user.first_name = "Jeff"
    user.last_name = "Dickey"
    user.address_1 = "211 112th Ave NE APT 312"
    user.city = "Bellevue"
    user.state = "WA"
    user.zip_code = "98004"
    user.phone_number = "971-222-7154"
    user.admin = true
    user.save
    user = User.new( :email => "wyatt@conne.cc", :password => "password", :password_confirm => "password" )
    user.first_name = "Wyatt"
    user.last_name = "Allen"
    user.address_1 = "211 112th Ave NE APT 312"
    user.city = "Bellevue"
    user.state = "WA"
    user.zip_code = "98004"
    user.phone_number = "971-222-7154"
    user.admin = true
    user.save
  end

  def self.down
    User.find_by_email("jeff@conne.cc").destroy
    User.find_by_email("wyatt@conne.cc").destroy
  end
end
