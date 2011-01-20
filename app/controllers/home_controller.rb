class HomeController < ApplicationController
  def home
    if user_signed_in?
      if current_user.orders.any?
        render 'dashboard'
      else
        render 'dashboard_no_orders'
      end
    else
      render 'splash'
    end
  end

  def my_cards
    @cards = current_user.recent_cards
  end
end
