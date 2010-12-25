class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound unless @order
  end

end
