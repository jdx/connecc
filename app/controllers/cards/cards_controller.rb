class Cards::CardsController < ApplicationController
  before_filter :norobots
  before_filter :hide_tip
  before_filter :get_card
  before_filter :ensure_user_is_giver, :only => [:edit, :update]

  def show
    card_404s = Rails.cache.read(card_404_accesses_cache_key(request)) || []
    if card_404s.count > 10
      raise ActiveRecord::RecordNotFound
    end
    @card.record_visit(request.remote_ip, current_user)
    if @card.giver == current_user
      if @card.message
        return render "giver_message"
      else
        return render "edit"
      end
    else
      if @card.message
        @contact_request = ContactRequest.new
        return render "message"
      else
        @notification_request = NotificationRequest.new
        return render "no_message"
      end
    end
  end

  def edit
  end

  def update
    @card.message = params[:card][:message]
    @card.save!
    @card.notification_requests.each { |r| CardNotifier.notification_request(r).deliver }
    redirect_to card_path(@card.code), :notice => "Updated card."
  end

  protected

  def card_404_accesses_cache_key(request)
    cache_key = "ip:#{ request.remote_ip }_card_404_accesses"
  end

  def get_card
    @card = Card.find_by_code(params[:code])
    unless @card
      # security to prevent scraping
      cards = Rails.cache.read(card_404_accesses_cache_key(request)) || []
      cards = cards.dup
      cards << params[:code] unless cards.include? params[:code]
      Rails.cache.write card_404_accesses_cache_key(request), cards, :expires_in => 10.minutes

      raise ActiveRecord::RecordNotFound
    end
  end

  def ensure_user_is_giver
    redirect_to card_path(@card.code) if @card.order.user != current_user
  end

  def hide_tip
    @hide_tip = true
  end
end
