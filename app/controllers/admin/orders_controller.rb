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

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to :action => 'show', :id => @order
    else
      render :action => 'edit'
    end
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

  def generate
    @order = Order.find(params[:id])
    @order.generate_cards
    @cards = @order.cards.order('id')
    render :template => "admin/cards/cards"
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
    @order = Order.find(params[:id])
    @order.cancel
    redirect_to admin_order_path(@order), :notice => 'Canceled'
  end

end
