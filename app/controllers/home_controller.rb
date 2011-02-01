class HomeController < ApplicationController
  def home
    if user_signed_in?
      if current_user.orders.any?
        render 'dashboard'
      else
        render 'dashboard_no_orders'
      end
    else
      if is_mobile_device?
        redirect_to new_user_session_path
      else
        render 'splash'
      end
    end
  end

  def my_cards
    @cards = current_user.recent_cards
  end
end
