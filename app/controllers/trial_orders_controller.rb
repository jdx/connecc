class TrialOrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :previous_trial_order_check

  def new
    @trial_order = TrialOrder.new
  end

  def create
    @trial_order = TrialOrder.new(params[:trial_order])
    @trial_order.user = current_user
    if @trial_order.save
      redirect_to dashboard_path, :notice => 'Expect your trial pack soon!'
    else
      render :new
    end
  end

  protected

  def previous_trial_order_check
    if current_user.orders.where(:type => "trial").exists?
      flash[:notice] = "Only one trial order per customer please"
      redirect_to dashboard_path
    end
  end

end
