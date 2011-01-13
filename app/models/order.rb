require 'active_support/secure_random'
require 'google4r/checkout'

class Order < ActiveRecord::Base
  before_create :update_state, :start_activation
  after_create :generate_cards
  before_update :update_state

  belongs_to :user
  has_many :cards
  belongs_to :buyer_billing_address, :class_name => 'Address'
  belongs_to :buyer_shipping_address, :class_name => 'Address'

  def charge_and_ship
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    command = frontend.create_charge_and_ship_order_command
    command.google_order_number = self.google_order_number
    command.send_to_google_checkout
    self.shipped = true
    self.save!
  end

  def to_s
    "Order #{ id }"
  end

  protected

  def update_state
    self.state = 'new'
    self.state = 'awaiting-charge' if self.activation_string == nil
    self.state = 'awaiting-activation' if self.authorization_amount
    self.state = 'awaiting-shipment' if self.authorization_amount and self.activation_string == nil
    self.state = 'shipped' if self.shipped
  end

  def start_activation
    # first try to find a user
    self.user = User.find_by_email(self.buyer_shipping_address.email)
    self.user = User.find_by_email(self.buyer_billing_address.email) unless user
    if user
      # user found, associate with account
      self.activation_string = nil
    else
      # No user found, send notification
      self.activation_string = ActiveSupport::SecureRandom.hex(16)
      OrderNotifier.activation(self).deliver
    end
  end

  def generate_cards
    cards_amount.times do
      cards << Card.new
    end
    save!
  end

end

class TaxTableFactory
  def effective_tax_tables_at(time)
    [ Google4R::Checkout::TaxTable.new(false) ]
  end
end
