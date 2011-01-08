class CardNotifier < ActionMailer::Base
  layout "email"
  default :from => "no-reply@conne.cc"

  def contact_request(contact_request)
    @contact_request = contact_request
    mail(:to => contact_request.card.giver.email_address_with_name,
         :subject => "Someone you gave your conne.cc card to wants to get back in touch!")
  end

  def notification_request(notification_request)
    @notification_request = notification_request
    mail(:to => notification_request.email,
         :subject => "#{ @notification_request.card.giver } has updated his conne.cc card for you")
  end
end
