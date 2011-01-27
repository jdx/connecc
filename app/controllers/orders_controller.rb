require_dependency 'pdf/card_generator'

class OrdersController < ApplicationController
  before_filter :authenticate_user!
  skip_after_filter :remember_last_viewed_page, :only => :preview

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
  end

  def preview
    # Make some fake data, this should never be saved
    card = Card.new
    card.code = 'd28cx'
    data = { :card => card,
             :first_name => params[:first_name],
             :last_name => params[:last_name],
             :company_name => params[:company_name] }

    pdf = PDF::CardGenerator.generate_card(data)
    image = Magick::ImageList.new
    image.from_blob(pdf.render)
    image.format = params[:format]
    send_data image.to_blob, :content_type => "image/#{ params[:format] }", :disposition => 'inline'
  end

end

