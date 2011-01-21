class TwilioController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def sms
    render :text => "conne.cc sms is not currently supported. We want to do this though!"
  end

  def call
    render :xml => { :response => {
                       :say => "Thank you for calling kuhnec.",
                       :gather => {
                         :numDigits => 1,
                         :action => 'handle_digits',
                         :method => 'POST'
                       }
                     }
                   }
  end

  def handle_digits
    render :xml => { :response => {
                       :dial => "9712227154"
                     }
                   }
  end
end
