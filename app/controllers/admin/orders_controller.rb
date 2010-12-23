class Admin::OrdersController < Admin::AdminController

  def index
    @status = params[:status]
    if @status
      @orders = Order.where :status => @status
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end

end
