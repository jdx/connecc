require_dependency 'cards/generator'

class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
  end

  def preview
    data = { :first_name => params[:first_name],
             :last_name => params[:last_name],
             :company_name => params[:company_name],
             :color => params[:color],
             :code => 'd28cx'}
    pdf = Cards::Generator.generate_card(data)
    image = Magick::ImageList.new('./tmp/cards/preview.pdf')
    image.format = 'PNG'
    send_data image.to_blob, :content_type => 'image/png', :disposition => 'inline'
  end

end

