class TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def sms
    render :text => "conne.cc sms is not currently supported. We want to do this though!", :content_type => 'text/plain'
  end

  def call
    render :text => '<?xml version="1.0" encoding="UTF-8"?>
                     <Response>
                       <Say>Thank you for calling kuhnec.</Say>
                       <Gather numDigits="1" method="POST" action="handle_digits">
                         Press 1 for support. Press 2 for sales.
                       </Gather>
                     </Response>', :content_type => 'text/xml'
  end

  def handle_digits
    render :text => '<?xml version="1.0" encoding="UTF-8"?>
                     <Response>
                       <Dial>971-222-7154</Dial>
                     </Response>', :content_type => 'text/xml'
  end
end
