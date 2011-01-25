require_dependency 'pdf/card_generator'
require_dependency 'pdf/envelope_generator'

class Admin::OrdersController < Admin::AdminController

  def index
    @state = params[:state]
    if @state
      @orders = Order.where(:state => @state)
      @total_orders = Order.where(:state => @state).count
    else
      @orders = Order
      @total_orders = Order.count
    end
    @orders = @orders.order('-id')
  end

  def show
    @order = Order.find(params[:id])
  end

  def envelope
    @order = Order.find(params[:id])
    pdf = PDF::EnvelopeGenerator.generate(@order)
    send_data pdf.render, :content_type => 'application/pdf', :disposition => 'inline'
  end

  def cards
    @order = Order.find(params[:id])
    data = { :cards => @order.cards,
             :first_name => @order.first_name,
             :last_name => @order.last_name,
             :company_name => @order.company_name }

    pdf = PDF::CardGenerator.generate_sheet(data)
    send_data pdf.render, :content_type => 'application/pdf', :disposition => 'inline'
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
