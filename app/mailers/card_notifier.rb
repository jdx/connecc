class CardNotifier < BaseNotifier
  default :from => "conne.cc <support@conne.cc>"

  def contact_request(contact_request)
    @contact_request = contact_request
    mail(:to => contact_request.card.giver.email_address_with_name,
         :reply_to => @contact_request.email,
         :from => "#{ @contact_request.email } <support@conne.cc>",
         :subject => @contact_request.message.blank? ?
                     "Someone you gave your conne.cc card to wants to get back in touch!" :
                     "conne.cc: \"#{ help.truncate(@contact_request.message.gsub(/[\n\r]/, ' ')) }\"")
  end

  def contact_request_sender(contact_request)
    @contact_request = contact_request
    mail(:to => contact_request.email,
         :from => "#{ @contact_request.email } <support@conne.cc>",
         :subject => @contact_request.message.blank? ?
                     "Someone you gave your conne.cc card to wants to get back in touch!" :
                     "conne.cc: \"#{ help.truncate(@contact_request.message.gsub(/[\n\r]/, ' ')) }\"")
  end

  def notification_request(notification_request)
    @notification_request = notification_request
    mail(:to => notification_request.email,
         :from => "#{ @notification_request.card.giver } <support@conne.cc>",
         :reply_to => @notification_request.card.giver.show_email ?
                      @notification_request.card.giver.email_address_with_name : nil,
         :subject => "conne.cc: #{ @notification_request.card.giver } said \"#{ help.truncate(@notification_request.card.message.gsub(/[\r\n]/, ' ')) }\"")
  end
end
