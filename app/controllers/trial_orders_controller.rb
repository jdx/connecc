require 'google4r/checkout'

class TrialOrdersController < OrdersController

  def new
    @trial_order = TrialOrder.new
  end

  def create
    @trial_order = TrialOrder.new(params[:trial_order])
    @trial_order.user = current_user
    if @trial_order.save
      @trial_order.add_cards(10)
      flash[:notice] = "Order placed! Your cards are on their way!"
      sign_in @trial_order.user
      redirect_to root_path
    else
      render :new
    end
  end

end
