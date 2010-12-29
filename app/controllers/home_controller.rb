class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => ["home", "tour", "privacy_policy"]

  def home
  end

  def tour
  end

  def dashboard
  end

  def privacy_policy
  end

end
