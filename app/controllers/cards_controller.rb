class CardsController < ApplicationController
  before_filter :get_card
  before_filter :authenticate_user!, :except => [:show, :contact_request]
  before_filter :ensure_user_is_giver, :only => [:edit, :update]

  def show
    Visit.record(@card, request.remote_ip, current_user)
    @contact_request = ContactRequest.new
  end

  def edit
  end

  def update
    @card.message = params[:card][:message]
    @card.save!
    redirect_to card_path(@card.code), :notice => "Updated card"
  end

  def contact_request
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
