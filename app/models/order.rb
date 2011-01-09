require 'active_support/secure_random'

class Order < ActiveRecord::Base
  before_create :update_state, :create_activation_string
  before_update :update_state

  belongs_to :user
  has_many :cards
  belongs_to :buyer_billing_address, :class_name => 'Address'
  belongs_to :buyer_shipping_address, :class_name => 'Address'


  def to_s
    "Order #{ id }"
  end

  def generate_cards
    cards_amount.times do
      cards << Card.new
    end
    save!
  end

  protected

  def update_state
    state = 'new'
    state = 'chargeable' if authorization_amount
    state = 'shipped' if shipped
  end

  def create_activation_string
    activation_string = ActiveSupport::SecureRandom.hex(16)
  end

end
