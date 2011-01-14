require 'google4r/checkout'

class OrdersController < ApplicationController

  def trial_get
    render :trial
  end

  def trial_post
    render :trial
  end

  def create
    @hide_login = true
  end

  def place
    @frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TaxTableFactory.new
    checkout_command = @frontend.create_checkout_command
    checkout_command.shopping_cart.create_item do |item|
      item.name = "100 conne.cc cards"
      item.description = "A pack of cards to use with conne.cc"
      item.unit_price = Money.new(1000, "USD")
      item.quantity = 1
    end
    checkout_command.analytics_data = request.POST['analyticsdata']
    checkout_command.shopping_cart.private_data = { 'cards_amount' => 100 }
    response = checkout_command.send_to_google_checkout
    redirect_to response.redirect_url
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
    @user.time_zone = 'Pacific Time (US & Canada)'
    @user.gender = 'm'
    @user.email = @order.buyer_billing_address.email unless @order.buyer_billing_address.email =~ /google.com$/ # because it's probably the proxy email, or they work for google and won't complain about typing an email address in :)
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

class TaxTableFactory
  def effective_tax_tables_at(time)
    [ Google4R::Checkout::TaxTable.new(false) ]
  end
end
