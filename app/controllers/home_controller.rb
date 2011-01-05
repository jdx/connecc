class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :dashboard

  def home
  end

  def tour
  end

  def dashboard
  end

  def privacy_policy
  end

end
