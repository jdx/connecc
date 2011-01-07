class HomeController < ApplicationController
  def home
    if current_user
      render :dashboard
    end
  end

  def tour
  end

  def faq
  end

  def about_us
  end

  def privacy_policy
  end

end
