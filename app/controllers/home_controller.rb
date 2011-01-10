class HomeController < ApplicationController
  layout :choose_layout

  def home
  end

  def tour
  end

  def faq
  end

  def about_us
  end

  def privacy_policy
  end

  def intro_video
  end

  protected

  def choose_layout
    if action_name == 'about_us'
      return 'wide'
    else
      return 'narrow'
    end
  end

end
