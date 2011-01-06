require 'google4r/checkout'

class GoogleCheckoutApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def callback
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = CheckoutCommandFactory.new
    handler = frontend.create_notification_handler

    begin
      notification = handler.handle(request.raw_post)
    rescue Google4R::Checkout::UnknownNotificationType => e
      render :text => "ignoring unknown notification type", :status => 200
      return
    end

    if notification.kind_of? NewOrderNotification
      order = Order.create! do |o|
        o.buyer_billing_address = Address.create_from_google(notification.buyer_billing_address)
        o.buyer_id = notification.buyer_id
        o.buyer_shipping_address = Address.create_from_google(notification.buyer_shipping_address)
        o.financial_order_state = notification.financial_order_state
        o.fulfillment_order_state = notification.fulfillment_order_state
        o.google_order_number = notification.google_order_number
      end
    elsif notification.kind_of? OrderStateChangeNotification
      order = Order.find_by_google_order_number(notification.google_order_number)
      order.financial_order_state = order.new_financial_order_state
      order.fulfillment_order_state = order.new_fulfillment_order_state
    end
  end
end
