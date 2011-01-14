require 'google4r/checkout'

class GoogleOrdersController < ApplicationController

  def create
    @frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TaxTableFactory.new
    checkout_command = @frontend.create_checkout_command
    checkout_command.shopping_cart.create_item do |item|
      item.name = "100 conne.cc cards"
      item.description = "A pack of cards to use with conne.cc"
      item.unit_price = Money.new(1000, "USD")
      item.quantity = 1
    end
    checkout_command.analytics_data = request.POST['analyticsdata']
    checkout_command.shopping_cart.private_data = { 'cards_amount' => 100 }
    response = checkout_command.send_to_google_checkout
    redirect_to response.redirect_url
  end

end

class TaxTableFactory
  def effective_tax_tables_at(time)
    [ Google4R::Checkout::TaxTable.new(false) ]
  end
end
