Given /^I am visiting Joe's connecc card$/ do
  Given %{Joe has an account}
  And %{Joe has cards}
  And %{I am on card "d28cx"}
end

Given /^Joe has cards$/ do
  user = User.find_by_email('joe@conne.cc')
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

Given /^Joe has posted a message$/ do
  card = Card.find_by_code('d28cx')
  card.message = "Great meeting you! Let's get in touch!"
  card.save!
  And %{I am on card "d28cx"}
end

Given /^"([^\"]*)" has registered for notifications on Joe's card$/ do |email|
  Given %{Joe has an account}
  And %{Joe has cards}
  notification = NotificationRequest.new
  notification.email = email
  notification.ip_address = '192.168.0.1'
  notification.card = Card.find_by_code('d28cx')
  notification.save!
end

