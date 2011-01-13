require 'net/http'
require 'uri'
require 'base64'
require 'google4r/checkout'
require 'hpricot'

class GoogleCheckoutApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def callback

    # Get the serial number we need to send back to google to get the actual notification
    serial_number = request.POST["serial-number"]

    # Set up the server we're going to talk to
    url = URI.parse(GOOGLE_CHECKOUT_NOTIFICATION_HISTORY_URL)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Set up the headers for the request (crazy base64 madness is per the api spec)
    header = {
      "Authorization" => "Basic " + Base64.encode64("#{ ENV['CONNECC_GOOGLE_MERCHANT_ID'] }:#{ ENV['CONNECC_GOOGLE_MERCHANT_KEY']}"),
      "Content-Type" => "application/xml;charset=UTF-8",
      "Accept" => "application/xml;charset=UTF-8"
    }

    # create the request
    req = Net::HTTP::Post.new(url.path, header)

    # xml we're going to send
    req.body = "
      <notification-history-request xmlns=\"http://checkout.google.com/schema/2\">
        <serial-number>#{ serial_number }</serial-number>
      </notification-history-request>
    "

    # Make the request
    res = http.start { |http| http.request(req) }

    # Error out if not a success
    unless res.kind_of? Net::HTTPSuccess
      res.error!
    end

    # show the log of the xml returned
    puts res.body

    # Set up our parser
    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TaxTableFactory.new
    handler = frontend.create_notification_handler

    # parse the data
    begin
      notification = handler.handle(res.body)
    rescue Google4R::Checkout::UnknownNotificationType => e
      render :text => "ignoring unknown notification type", :status => 200
      return
    end

    hpricot = Hpricot(res.body)

    # Find out what type of notification it is and handle it accordingly
    if notification.kind_of? Google4R::Checkout::NewOrderNotification
      order = Order.create! do |o|
        o.buyer_billing_address = Address.create! do |a|
          google = notification.buyer_billing_address
          a.address1 = google.address1
          a.address2 = google.address2
          a.city = google.city
          a.company_name = google.company_name
          a.name = google.contact_name
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
          a.name = google.contact_name
          a.country_code = google.country_code
          a.email = google.email
          a.phone = google.phone
          a.postal_code = google.postal_code
          a.region = google.region
        end
        o.first_name = hpricot.at("//buyer-shipping-address/structured-name/first-name").inner_html
        o.last_name = hpricot.at("//buyer-shipping-address/structured-name/last-name").inner_html
        o.google_order_number = notification.google_order_number
        o.cards_amount = notification.shopping_cart.private_data['cards_amount']
      end
    elsif notification.kind_of? Google4R::Checkout::AuthorizationAmountNotification
      # This does not appear to be working... :(
      order = Order.find_by_google_order_number(notification.google_order_number)
      order.authorization_amount = notification.authorization_amount
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
