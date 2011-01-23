require 'RMagick'

class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
  end

  def preview
    image = Magick::ImageList.new("#{ RAILS_ROOT }/lib/test.pdf")
    image.scale(300,300)
    image.format = 'PNG'
    send_data image.to_blob, :content_type => 'image/png', :disposition => 'inline'
  end

end

