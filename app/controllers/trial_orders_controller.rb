require 'google4r/checkout'

class TrialOrdersController < ApplicationController

  def new
    @trial_order = TrialOrder.new
    @trial_order.user = User.new
    @trial_order.user.gender = 'm'
    @trial_order.user.time_zone = 'Pacific Time (US & Canada)'
    @trial_order.buyer_shipping_address = Address.new
  end

  def create
    @trial_order = TrialOrder.new(params[:trial_order])
    if @trial_order.save
      flash[:notice] = "Order placed! Your cards are on their way!"
      sign_in @trial_order.user
      redirect_to root_path
    else
      render :new
    end
  end

end
