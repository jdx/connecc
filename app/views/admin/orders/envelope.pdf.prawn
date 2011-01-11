require 'prawn/layout'
require 'prawn/measurement_extensions'

pdf.font "Helvetica", :size => 14

pdf.fill_color "1D4088"
pdf.text 'conne.cc', :style => :bold
pdf.fill_color "000000"
pdf.text '211 112th Ave NE APT 312'
pdf.text 'Bellevue, WA 98004'
pdf.fill_color "1D4088"
pdf.draw_text '>', :at => [2.6.in, 3.0.in], :size => 80

pdf.bounding_box [2.2.in, 2.in], :width => 3.5.in, :height => 2.in do
  pdf.font "Helvetica", :size => 16
  pdf.text @address.name, :style => :bold
  pdf.fill_color "000000"
  pdf.text @address.address1
  if @address.address2
    pdf.text @address.address2
  end
  pdf.text "#{ @address.city }, #{ @address.region } #{ @address.postal_code }"
end
