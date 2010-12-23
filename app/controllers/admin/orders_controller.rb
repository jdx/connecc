class Admin::OrdersController < Admin::AdminController

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

end
