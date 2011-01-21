class TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def sms
    render :text => "conne.cc sms is not currently supported. We want to do this though!", :content_type => 'text/plain'
  end

  def call
    render :text => '<?xml version="1.0" encoding="UTF-8"?>
                     <response>
                       <say>Thank you for calling kuhnec.</say>
                       <gather numDigits="1" method="POST" action="handle_digits">
                         Press 1 for support. Press 2 for sales.
                       </gather>
                     </response>', :content_type => 'text/xml'
  end

  def handle_digits
    render :text => '<?xml version="1.0" encoding="UTF-8"?>
                     <response>
                       <dial>971-222-7154</say>
                     </response>', :content_type => 'text/xml'
  end
end
