require 'google4r/checkout'

class OrdersController < ApplicationController

  def new
    @hide_login = true
  end

  def activate
    if current_user
      # I'm not sure how exactly to handle this case yet,
      # but it'll only happen for users activating an order
      # that already have an account and are already logged in
      sign_out(current_user)
      return redirect_to
    end
    @order = Order.find_by_activation_string(params[:activation_string])
    raise ActiveRecord::RecordNotFound unless @order
    @user = User.new
    @user.first_name = @order.first_name
    @user.last_name = @order.last_name
    @user.gender = 'm'
    @user.time_zone = 'Pacific Time (US & Canada)'
    @user.email = @order.email unless @order.email =~ /google.com$/ # because it's probably the proxy email, or they work for google and won't complain about typing an email address in :)
    @hide_login = true
    render :activate
  end

  def activate_and_create_user
    @order = Order.find_by_activation_string(params[:activation_string])
    raise ActiveRecord::RecordNotFound unless @order
    @user = User.create params[:user]
    if @user.save
      @order.user = @user
      @order.activation_string = nil
      @order.save
      flash[:notice] = "Account created successfully. Your cards are on their way!"
      sign_in_and_redirect(@user)
    else
      @hide_login = true
      render :activate
    end
  end

end

