class TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def sms
    render :text => "conne.cc sms is not currently supported. We want to do this though!", :content_type => 'text/plain'
  end

  def call
    @response = { :say => "Thank you for calling kuhnec.",
                  :gather => {
                    :numDigits => 1,
                    :action => 'handle_digits',
                    :method => 'POST'
                  }
                }
    render :xml => @response
  end

  def handle_digits
    @response = { :dial => "9712227154" }
    render :xml => @response
  end
end
