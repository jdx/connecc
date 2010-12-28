class CardNotifier < ActionMailer::Base
  layout "email"
  default :from => "no-reply@conne.cc"

  def contact_request(contact_request)
    @contact_request = contact_request
    mail(:to => contact_request.card.giver.email_address_with_name,
         :subject => "Someone you gave your conne.cc card to wants to get back in touch!")
  end
end
