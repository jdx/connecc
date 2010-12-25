class CardsController < ApplicationController
  before_filter :get_card
  before_filter :authenticate_user!, :except => :show
  before_filter :ensure_user_is_giver, :only => [:edit, :update]

  def show
    @giver = @card.order.user

    # Find a visit by user id if the user is logged in
    visit = Visit.find_by_user_id(current_user.id) if current_user
    # Find a visit by ip address if there was none found
    visit = Visit.find_by_ip_address(request.remote_ip) unless visit
    if visit
      # Visit exists, update the count and values if they changed
      visit.user = current_user
      visit.ip_address = request.remote_ip
      visit.increment!(:count)
    else
      Visit.create! :user => current_user, :ip_address => request.remote_ip, :card => @card unless visit
    end
  end

  def edit
  end

  def update
    @card.message = params[:card][:message]
    @card.save!
    redirect_to card_path(@card.code), :notice => "Updated card"
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
