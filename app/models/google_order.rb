require 'active_support/secure_random'
require 'google4r/checkout'

class GoogleOrder < Order
  after_initialize :set_type
  before_save :update_state

  before_create :start_activation

  def cancel
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    command = frontend.create_cancel_order_command
    command.google_order_number = self.google_order_number
    command.send_to_google_checkout
    self.shipped = true
    self.save!
  end

  def ship
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    command = frontend.create_charge_and_ship_order_command
    command.google_order_number = self.google_order_number
    command.send_to_google_checkout
    self.shipped = true
    self.save!
  end

  protected

  def set_type
    self.type = 'GoogleOrder'
  end

  def update_state
    self.state = 'new'
    self.state = 'awaiting-charge' if self.user
    self.state = 'awaiting-activation' if self.authorization_amount
    self.state = 'awaiting-shipment' if self.authorization_amount and self.user
    self.state = 'shipped' if self.shipped
    self.state = 'canceled' if self.canceled
  end

  def start_activation
    unless self.user
      # first try to find a user
      self.user = User.find_by_email(self.email)
      self.user = User.find_by_email(self.email) unless self.user
      unless user
        # No user found, send notification and await activation
        self.activation_string = ActiveSupport::SecureRandom.hex(16)
        OrderNotifier.activation(self).deliver
      end
    end
  end

end

class TaxTableFactory
  def effective_tax_tables_at(time)
    [ Google4R::Checkout::TaxTable.new(false) ]
  end
end
