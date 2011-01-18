class Cards::ContactRequestsController < Cards::CardsController
  def new
    @contact_request = ContactRequest.new
  end

  def create
    @contact_request = ContactRequest.new params[:contact_request]
    @contact_request.card = @card
    @contact_request.ip_address = request.remote_ip
    if @contact_request.save
      CardNotifier.contact_request(@contact_request).deliver
      if @contact_request.send_me_a_copy
        CardNotifier.contact_request_sender(@contact_request).deliver
      end
      redirect_to card_path(@card.code), :notice => "#{ @card.giver.first_name } will be getting a hold of you shortly."
    else
      render :new
    end
  end
end

