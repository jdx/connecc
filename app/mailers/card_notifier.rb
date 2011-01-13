class CardNotifier < BaseNotifier
  def contact_request(contact_request)
    @contact_request = contact_request
    mail(:to => contact_request.card.giver.email_address_with_name,
         :reply_to => @contact_request.email,
         :subject => @contact_request.message.blank? ?
                     "Someone you gave your conne.cc card to wants to get back in touch!" :
                     "conne.cc: \"#{ help.truncate @contact_request.message.tr('\n', ' ') }\"")
  end

  def notification_request(notification_request)
    @notification_request = notification_request
    mail(:to => notification_request.email,
         :reply_to => @notification_request.card.giver.email_address_with_name,
         :subject => "conne.cc: #{ @notification_request.card.giver } said \"#{ help.truncate @notification_request.card.message.tr('\n', ' ') }\"")
  end
end
