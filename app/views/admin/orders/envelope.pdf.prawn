require 'prawn/layout'
require 'prawn/measurement_extensions'

pdf.font_families.update 'Cabin' => { :bold => "#{ RAILS_ROOT }/lib/Cabin-Bold.ttf" }

pdf.font "Cabin", :size => 16, :style => :bold

pdf.fill_color "1D4088"
pdf.text 'conne.cc', :style => :bold
pdf.fill_color "000000"
pdf.text '211 112th Ave NE #312'
pdf.text 'Bellevue, WA 98004'
pdf.fill_color "1D4088"
pdf.draw_text '>', :at => [2.6.in, 2.9.in], :size => 100

pdf.bounding_box [2.2.in, 2.in], :width => 3.5.in, :height => 2.in do
  pdf.font "Cabin", :size => 18, :style => :bold
  pdf.text @order.user.name, :style => :bold
  pdf.fill_color "000000"
  pdf.text @order.address1
  if @order.address2
    pdf.text @order.address2
  end
  pdf.text "#{ @order.city }, #{ @order.region } #{ @order.postal_code }"
end
