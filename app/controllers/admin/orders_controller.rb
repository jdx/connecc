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
    @address = Order.find(params[:id]).buyer_shipping_address
    prawnto :prawn => {
      :margin => 0,
      :page_layout => :landscape,
      :page_size => [9.2.cm, 16.5.cm]
    }
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
