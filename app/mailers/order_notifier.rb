class OrderNotifier < BaseNotifier
  default :from => "conne.cc <sales@conne.cc>"

  def activation(order)
    @order = order
    mail(:to => order.buyer_billing_address.email_address_with_name,
         :subject => "Activate your conne.cc account")
  end
end
