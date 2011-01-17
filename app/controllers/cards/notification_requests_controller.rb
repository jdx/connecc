class Cards::NotificationRequestsController < Cards::CardsController
  def create
    @notification_request = NotificationRequest.new params[:notification_request]
    @notification_request.card = @card
    @notification_request.user = current_user
    @notification_request.ip_address = request.remote_ip
    if @notification_request.save
      redirect_to card_path(@card.code), :notice => "We'll let you know when #{ @card.giver.first_name } posts a message for you."
    else
      render :new
    end
  end
end

