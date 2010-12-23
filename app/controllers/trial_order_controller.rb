class TrialOrderController < ApplicationController
  before_filter :previous_trial_order_check

  def new
    @trial_order = Order.new
  end

  def create
    @trial_order = Order.new
    @trial_order.user = current_user
    @trial_order.placed_at = DateTime.now
    @trial_order.trial = true
    if @trial_order.save
      redirect_to dashboard_path, :notice => 'Expect your trial pack soon!'
    else
      render :new
    end
  end

  protected

  def previous_trial_order_check
    if current_user.orders.where(:trial => true).exists?
      flash[:notice] = "Only one trial order per customer please"
      redirect_to dashboard_path
    end
  end

end
