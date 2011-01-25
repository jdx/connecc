require_dependency 'google/checkout_handler'
require 'google4r/checkout'
require 'base64'

class GoogleOrdersController < OrdersController
  skip_before_filter :verify_authenticity_token, :only => :callback
  skip_before_filter :authenticate_user!, :only => :callback

  def new
    @google_order = GoogleOrder.new
    @google_order.first_name = current_user.first_name
    @google_order.last_name = current_user.last_name
    @google_order.company_name = current_user.company_name
  end

  def create
    @google_order = GoogleOrder.new params[:google_order]
    unless @google_order.valid?
      return render :new
    end
    @frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = Google::TaxTableFactory.new
    checkout_command = @frontend.create_checkout_command
    checkout_command.shopping_cart.create_item do |item|
      item.name = "100 conne.cc cards"
      item.description = "A pack of cards to use with conne.cc"
      item.unit_price = Money.new(1000, "USD")
      item.quantity = 1
    end
    checkout_command.analytics_data = request.POST['analyticsdata']
    checkout_command.shopping_cart.private_data =
      { 'user_id' => current_user.id,
        'first_name' => @google_order.first_name,
        'last_name' => @google_order.last_name,
        'company_name' => @google_order.company_name,
        'cards_amount' => 100 }
    response = checkout_command.send_to_google_checkout
    redirect_to response.redirect_url
  end

  def callback
    serial_number = request.POST["serial-number"]
    handler = Google::CheckoutHandler.new(serial_number)
    handler.perform
    # not using DJ yet...
    # Delayed::Job.enqueue Google::CheckoutHandler.new(serial_number)
    render :text => "<notification-acknowledgment xmlns=\"http://checkout.google.com/schema/2\" serial-number=\"#{ serial_number }\"/>"
  end
end

