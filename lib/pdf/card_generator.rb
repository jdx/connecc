require 'prawn'
require 'prawn/measurement_extensions'

module PDF
  class CardGenerator
    def self.generate_card(data)
      pdf = Prawn::Document.new :margin => 0, :page_size => [14.in, 4.in]

      pdf.scale(4)

      pdf.font_families.update 'Cabin' => { :normal => "#{ RAILS_ROOT }/lib/assets/Cabin-Bold.ttf" }
      pdf.font "Cabin"

      self.render_card(pdf, data, data[:card])

      return pdf
    end

    def self.generate_sheet(data)
      pdf = Prawn::Document.new :margin => 0, :page_size => [8.5.in, 11.in]

      pdf.font_families.update 'Cabin' => { :normal => "#{ RAILS_ROOT }/lib/assets/Cabin-Bold.ttf" }
      pdf.font "Cabin"

      cards = data[:cards]
      index = 0

      # repeat for every page
      while cards[index] do

        # get a bounding box for the current page
        # this is where I actually set the margins, it seems to work better this way
        pdf.bounding_box [0.75.in, 10.5.in], :width => 7.in, :height => 10.in do

          pdf.define_grid :columns => 2, :rows => 5

          pdf.grid.show_all # remove this to disable debug grid

          pdf.grid.rows.times do |row|
            pdf.grid.columns.times do |col|

              # create bounding box for the current cell
              pdf.grid(row, col).bounding_box do

                flip = col == 0
                pdf.rotate(flip ? 180 : 0, :origin => [0, 0]) do

                  pdf.translate(-3.5.in, -2.in) if flip

                  # top card
                  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], :width => 3.5.in, :height => 1.in do
                    self.render_card(pdf, data, cards[index])
                  end

                  # bottom card
                  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 1.in], :width => 3.5.in, :height => 1.in do
                    self.render_card(pdf, data, cards[index])
                  end

                end
              end

              # move to the next card
              index += 1
            end
          end
        end

        pdf.start_new_page if cards[index]
      end
      return pdf
    end

    protected

    def self.render_card(pdf, data, card)
      pdf.image "#{ RAILS_ROOT }/lib/assets/grad.png", :at => [ 0.in, 1.in ], :width => 0.9.in, :height => 1.in
      pdf.fill_color = "ffffff"
      pdf.draw_text data[:first_name], :at => [0.32.in, 0.7.in], :size => 15
      pdf.fill_color = "000000"
      pdf.draw_text data[:last_name], :at => [0.9.in, 0.7.in], :size => 15
      pdf.draw_text data[:company_name], :at => [0.7.in, 0.5.in], :size => 12
      pdf.image "#{ RAILS_ROOT }/lib/assets/logo.2.png", :at => [2.65.in, 0.95.in], :width => 0.75.in
      pdf.draw_text "http://conne.cc/#{ card.code }", :at => [1.in, 0.1.in], :size => 16
    end
  end
end

