require 'active_support/secure_random'

class Order < ActiveRecord::Base
  before_create :update_state, :create_activation_string
  after_create :send_activation_email, :generate_cards
  before_update :update_state

  belongs_to :user
  has_many :cards
  belongs_to :buyer_billing_address, :class_name => 'Address'
  belongs_to :buyer_shipping_address, :class_name => 'Address'


  def to_s
    "Order #{ id }"
  end

  protected

  def update_state
    self.state = 'new'
    self.state = 'awaiting-charge' if activation_string == nil
    self.state = 'awaiting-activation' if authorization_amount
    self.state = 'awaiting-shipment' if authorization_amount and activation_string == nil
    self.state = 'shipped' if shipped
  end

  def create_activation_string
    self.activation_string = ActiveSupport::SecureRandom.hex(16)
  end

  def send_activation_email
    OrderNotifier.activation(self).deliver
  end

  def generate_cards
    cards_amount.times do
      cards << Card.new
    end
    save!
  end

end
