class Order < ActiveRecord::Base

  belongs_to :user
  has_many :cards
  belongs_to :buyer_billing_address, :class_name => 'Address'
  belongs_to :buyer_shipping_address, :class_name => 'Address'


  def to_s
    "Order #{ id }"
  end

  def generate_cards
    self.cards_amount.times do
      self.cards << Card.new
    end
    self.save!
  end

end
