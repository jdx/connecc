class CardNotifier < BaseNotifier
  def contact_request(contact_request)
    @contact_request = contact_request
    mail(:to => contact_request.card.giver.email_address_with_name,
         :subject => @contact_request.message ?
                     "conne.cc: \"#{ @notification_request.card.truncate }\"" :
                     "Someone you gave your conne.cc card to wants to get back in touch!")
  end

  def notification_request(notification_request)
    @notification_request = notification_request
    mail(:to => notification_request.email,
         :subject => "conne.cc: #{ @notification_request.card.giver } said \"#{ @notification_request.card.truncate }\"")
  end
end
