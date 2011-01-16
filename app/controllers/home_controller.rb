class HomeController < ApplicationController
  def home
    if user_signed_in?
      return redirect_to orders_path unless current_user.orders.any?
      return render 'dashboard'
    else
      return render 'splash'
    end
  end
end
