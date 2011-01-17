require 'prawn/measurement_extensions'

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

  def envelope
    @order = Order.find(params[:id])
    @address = @order.buyer_billing_address
    prawnto :prawn => {
      :margin => 0,
      :page_layout => :landscape,
      :page_size => [9.2.cm, 16.5.cm]
    }
  end

  def cards
    @cards = Order.find(params[:id]).cards.order('id')
    render :template => "admin/cards/cards"
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship
    redirect_to admin_order_path(@order), :notice => 'Shipped'
  end

  def cancel
    if request.get?
      @order = Order.find(params[:id])
    else
      @order = Order.find(params[:id])
      if params[:reason].blank?
        return redirect_to admin_order_path(@order), :alert => "You must specify a reason"
      end
      @order.cancel(params[:reason])
      redirect_to admin_order_path(@order), :notice => 'Canceled'
    end
  end

end
