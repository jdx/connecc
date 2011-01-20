require 'google4r/checkout'

class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
  end

end

