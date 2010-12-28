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

  def generate
    @order = Order.find(params[:id])
    unless @order.generated_at
      @order.generate_cards
      flash[:notice] = "Cards generated"
    end
    redirect_to admin_order_path(@order)
  end

  def cards
    @order = Order.find(params[:id])
    render :cards, :layout => "print"
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship
    redirect_to admin_order_path(@order), :notice => 'Order marked as shipped'
  end

end
