require 'net/http'
require 'uri'
require 'base64'
require 'google4r/checkout'

class GoogleCheckoutApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def callback

    serial_number = request.POST["serial-number"]

    url = URI.parse(GOOGLE_CHECKOUT_NOTIFICATION_HISTORY_URL)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    header = {
      "Authorization" => "Basic " + Base64.encode64("#{ ENV['CONNECC_GOOGLE_MERCHANT_ID'] }:#{ ENV['CONNECC_GOOGLE_MERCHANT_KEY']}"),
      "Content-Type" => "application/xml;charset=UTF-8",
      "Accept" => "application/xml;charset=UTF-8"
    }

    req = Net::HTTP::Post.new(url.path, header)

    req.body = "
      <notification-history-request xmlns=\"http://checkout.google.com/schema/2\">
        <serial-number>#{ serial_number }</serial-number>
      </notification-history-request>
    "

    res = http.start { |http| http.request(req) }

    unless res.kind_of? Net::HTTPSuccess
      res.error!
    end

    puts res.body

    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    handler = frontend.create_notification_handler

    begin
      notification = handler.handle(res.body)
    rescue Google4R::Checkout::UnknownNotificationType => e
      render :text => "ignoring unknown notification type", :status => 200
      return
    end

    if notification.kind_of? Google4R::Checkout::NewOrderNotification
      order = Order.create! do |o|
        o.buyer_billing_address = Address.create! do |a|
          google = notification.buyer_billing_address
          a.address1 = google.address1
          a.address2 = google.address2
          a.city = google.city
          a.company_name = google.company_name
          a.contact_name = google.contact_name
          a.country_code = google.country_code
          a.email = google.email
          a.phone = google.phone
          a.postal_code = google.postal_code
          a.region = google.region
        end
        o.buyer_shipping_address = Address.create! do |a|
          google = notification.buyer_shipping_address
          a.address1 = google.address1
          a.address2 = google.address2
          a.city = google.city
          a.company_name = google.company_name
          a.contact_name = google.contact_name
          a.country_code = google.country_code
          a.email = google.email
          a.phone = google.phone
          a.postal_code = google.postal_code
          a.region = google.region
        end
        o.financial_order_state = notification.financial_order_state
        o.fulfillment_order_state = notification.fulfillment_order_state
        o.google_order_number = notification.google_order_number
        o.cards_amount = notification.shopping_cart.private_data['cards_amount']
      end
    elsif notification.kind_of? Google4R::Checkout::OrderStateChangeNotification
      order = Order.find_by_google_order_number(notification.google_order_number)
      order.financial_order_state = order.new_financial_order_state
      order.fulfillment_order_state = order.new_fulfillment_order_state
      order.save!
    end
    render :text => "<notification-acknowledgment xmlns=\"http://checkout.google.com/schema/2\" serial-number=\"#{ serial_number }\"/>"
  end
end

class TaxTableFactory
  def effective_tax_tables_at(time)
    [ Google4R::Checkout::TaxTable.new(false) ]
  end
end
