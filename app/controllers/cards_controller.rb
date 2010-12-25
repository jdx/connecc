class HomeController < ApplicationController
  def show
    @card = Card.find_by_code(params[:code])
  end
end
