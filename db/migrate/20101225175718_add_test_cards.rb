class AddTestCards < ActiveRecord::Migration
  def self.up
    user = User.new(:email => "joe@blow.com", :password => "password")
    user.first_name = "Joe"
    user.last_name = "Blow"
    user.save
    order = TrialOrder.create! :user => user, :address => "211 112th Ave NE APT 312", :city => "Bellevue", :state => "WA", :zip => "98004"
    order.generate_cards
    order.ship
    card = order.cards.first
    card.code = 'aaaaa'
    card.save!
  end

  def self.down
  end
end
