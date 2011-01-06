class HomeController < ApplicationController
  def home
    if current_user
      render :dashboard
    end
  end

  def tour
  end

  def privacy_policy
  end

end
