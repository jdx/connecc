class HomeController < ApplicationController
  def home
    return render 'dashboard' if user_signed_in?
    return render 'splash'
  end
end
