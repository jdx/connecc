require 'prawn/layout'
require 'prawn/measurement_extensions'

pdf.stroke do
  pdf.line [0.in,9.in,8.5.in,9.in]
  pdf.line [0.in,7.in,8.5.in,7.in]
  pdf.line [0.in,5.in,8.5.in,5.in]
  pdf.line [0.in,3.in,8.5.in,3.in]
  pdf.line [0.in,1.in,8.5.in,1.in]
  pdf.line [3.5.in,0.in,3.5.in,11.in]
  pdf.line [7.in,0.in,7.in,11.in]
end

