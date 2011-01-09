class AddTestCards < ActiveRecord::Migration
  def self.up
    user = User.new(:email => "joe@conne.cc", :password => "password")
    user.name = "Joe Blow"
    user.save
    address = Address.create! :address1 => "211 112th Ave NE APT 312",
                              :city => "Bellevue",
                              :country_code => "US",
                              :contact_name => "Joe Blow",
                              :email => "joe@conne.cc",
                              :postal_code => "98004",
                              :region => "Washington"

    order = Order.create! :user => user,
                          :buyer_billing_address => address,
                          :buyer_id => '1',
                          :buyer_shipping_address => address,
                          :financial_order_state => 'paid',
                          :fulfillment_order_state => 'unshipped',
                          :google_order_number => '8'

    order.generate_cards
    card = order.cards.first
    card.code = 'd28cx'
    card.save!
  end

  def self.down
  end
end
