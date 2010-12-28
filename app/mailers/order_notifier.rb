class OrderNotifier < ActionMailer::Base
  default :from => "no-reply@conne.cc"

  def placed(order)
    @order = order
    mail(:to => order.user.email_address_with_name)
  end
end
