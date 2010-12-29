require 'prawn/layout'
require 'prawn/measurement_extensions'

pdf.font "Helvetica"

index = 0
while @cards[index] do
  # set the bounds for the full page
  pdf.bounding_box [0,11.in], :width => 7.in, :height => 10.in do
    # set our pages grid
    pdf.define_grid(:columns => 2, :rows => 5)

    # iterate over each item
    2.times do |col|
      5.times do |row|

        pair = pdf.grid(row,col)

        # Top card
        pdf.bounding_box [pair.left + 0.2.in, pair.top], :width => 3.5.in, :height => 1.in do
          pdf.move_down 0.35.in
          pdf.fill_color "000000"
          pdf.text @cards[index].order.user.to_s
          pdf.fill_color "1D4088"
          pdf.text @cards[index].to_s
          pdf.draw_text ">", :at => [2.6.in, 0.15.in], :size => 75
        end

        # Bottom card
        pdf.bounding_box [pair.left + 0.2.in, pair.top - 1.in], :width => 3.5.in, :height => 1.in do
          pdf.move_down 0.35.in
          pdf.fill_color "000000"
          pdf.text @cards[index].order.user.to_s
          pdf.fill_color "1D4088"
          pdf.text @cards[index].to_s
          pdf.draw_text ">", :at => [2.6.in, 0.15.in], :size => 75
        end

        index = index + 1

      end
    end
  end
  pdf.start_new_page if @cards[index]
end

# gridlines
pdf.stroke do
  pdf.line [0.in,10.in,8.5.in,10.in]
  pdf.line [0.in,9.in,8.5.in,9.in]
  pdf.line [0.in,8.in,8.5.in,8.in]
  pdf.line [0.in,7.in,8.5.in,7.in]
  pdf.line [0.in,6.in,8.5.in,6.in]
  pdf.line [0.in,5.in,8.5.in,5.in]
  pdf.line [0.in,4.in,8.5.in,4.in]
  pdf.line [0.in,3.in,8.5.in,3.in]
  pdf.line [0.in,2.in,8.5.in,2.in]
  pdf.line [0.in,1.in,8.5.in,1.in]
  pdf.line [3.5.in,0.in,3.5.in,11.in]
  pdf.line [7.in,0.in,7.in,11.in]
end

