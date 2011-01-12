class CardsController < ApplicationController
  before_filter :get_card
  before_filter :authenticate_user!, :except => [:show, :notification_request, :contact_request_get, :contact_request_post]
  before_filter :ensure_user_is_giver, :only => :update

  def show
    Visit.record(@card, request.remote_ip, current_user)
    if @card.message
      @contact_request = ContactRequest.new
    else
      @notification_request = NotificationRequest.new
    end
  end

  def update
    @card.message = params[:card][:message]
    @card.save!
    @card.notification_requests.each { |r| CardNotifier.notification_request(r).deliver }
    redirect_to card_path(@card.code), :notice => "Updated card"
  end

  def notification_request
    @notification_request = NotificationRequest.new params[:notification_request]
    @notification_request.card = @card
    @notification_request.user = current_user
    @notification_request.ip_address = request.remote_ip
    if @notification_request.save
      flash[:notice] = "We'll let you know when #{ @card.giver } posts a message for you."
      @notification_request = nil # so the form doesn't display
    end
    render :show
  end

  def contact_request_get
    @contact_request = ContactRequest.new
    render :show
  end

  def contact_request_post
    @contact_request = ContactRequest.new params[:contact_request]
    @contact_request.card = @card
    @contact_request.user = current_user
    @contact_request.ip_address = request.remote_ip
    if @contact_request.save
      CardNotifier.contact_request(@contact_request).deliver
      flash[:notice] = "#{ @card.giver } will be getting a hold of you shortly."
      @contact_request = nil # so the form doesn't display
    end
    render :show
  end

  protected

  def get_card
    @card = Card.find_by_code(params[:code])
    raise ActiveRecord::RecordNotFound unless @card
  end

  def ensure_user_is_giver
    redirect_to :show if @card.order.user != current_user
  end
end
