class HomeController < ApplicationController
  layout "wide", :only => 'about_us'
  layout "narrow", :except => 'about_us'

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

end
