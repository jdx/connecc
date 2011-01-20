class HomeController < ApplicationController
  def home
    if user_signed_in?
      if current_user.orders.any?
        @cards = current_user.cards.where(:visited => true).order('cards.updated_at DESC').limit(10)
        render 'dashboard'
      else
        render 'dashboard_no_orders'
      end
    else
      render 'splash'
    end
  end

  def my_cards
    @cards = current_user.cards.where(:visited => true).order('cards.updated_at DESC')
  end
end
