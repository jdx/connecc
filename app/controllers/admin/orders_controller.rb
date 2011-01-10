class Admin::OrdersController < Admin::AdminController

  def index
    @status = params[:status]
    if @status
      @orders = Order.where(:status => @status)
      @total_orders = Order.where(:status => @status).count
    else
      @orders = Order.all
      @total_orders = Order.count
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def cards
    @cards = Order.find(params[:id]).cards
    render :template => "admin/cards/cards"
  end

  def ship
    @order = Order.find(params[:id])
    @order.charge_and_ship
    redirect_to admin_order_path(@order), :notice => 'Charged and shipped'
  end

end
