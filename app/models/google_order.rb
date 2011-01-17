require 'active_support/secure_random'
require 'google4r/checkout'

class GoogleOrder < Order

  def cancel(reason)
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    command = frontend.create_cancel_order_command
    command.reason = reason
    command.google_order_number = self.google_order_number
    command.send_to_google_checkout
    super
  end

  def ship
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    command = frontend.create_charge_and_ship_order_command
    command.google_order_number = self.google_order_number
    command.send_to_google_checkout
    super
  end

  protected

  def set_type
    self.type = 'GoogleOrder'
  end

end

class TaxTableFactory
  def effective_tax_tables_at(time)
    [ Google4R::Checkout::TaxTable.new(false) ]
  end
end
