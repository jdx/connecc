class AddTestCards < ActiveRecord::Migration
  def self.up
    order = TrialOrder.create! :user => User.first, :address => "211 112th Ave NE APT 312", :city => "Bellevue", :state => "WA", :zip => "98004"
    order.generate_cards
    order.ship
    card = order.cards.first
    card.code = 'aaaaa'
    card.save!
  end

  def self.down
    order = User.first.trial_order
    order.destroy
  end
end
