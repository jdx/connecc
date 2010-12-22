class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => "tour"

  def tour
  end

  def dashboard
  end

end
