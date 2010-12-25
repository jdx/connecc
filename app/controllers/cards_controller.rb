class CardsController < ApplicationController
  def show
    @card = Card.find_by_code(params[:code])
    raise ActiveRecord::RecordNotFound unless @card
    @giver = @card.order.user
  end
end
