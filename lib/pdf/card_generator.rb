require 'prawn'
require 'prawn/fast_png'
require 'prawn/measurement_extensions'

require_dependency 'graphics/gradient'

module PDF
  class CardGenerator
    def self.generate_card(data)
      pdf = Prawn::Document.new :margin => 0, :page_size => [14.in, 8.in]

      pdf.font_families.update 'Cabin' => { :normal => "#{ Rails.root.to_s }/lib/assets/Cabin-Bold.ttf" }
      pdf.font "Cabin"

      pdf.scale(4) do

        # top card
        pdf.bounding_box [0, 4.in], :width => 14.in, :height => 4.in do
          self.render_card(pdf, data, data[:card])
        end

        # bottom card
        pdf.bounding_box [0, 5.in], :width => 14.in, :height => 4.in do
          self.render_card(pdf, data, data[:card])
        end
      end

      pdf.stroke_line([0,4.in, 14.in, 4.in])

      return pdf
    end

    def self.generate_sheet(data)
      pdf = Prawn::Document.new :margin => 0, :page_size => [8.5.in, 11.in]

      pdf.font_families.update 'Cabin' => { :normal => "#{ Rails.root.to_s }/lib/assets/Cabin-Bold.ttf" }
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
      padding = 0.2.in
      gradient_width = padding + pdf.width_of(data[:first_name], :size => 15) + 0.04.in
      pdf.image Graphics::Gradient.new(gradient_width, "000088", "0000ff"), :at => [ 0.in, 1.in ], :height => 1.in, :width => gradient_width
      self.render_name(pdf, data[:first_name], data[:last_name], data[:company_name], padding, gradient_width)
      self.render_logo(pdf, "#{ Rails.root.to_s }/lib/assets/logo.2.png")
      self.render_url(pdf, "http://conne.cc/#{ card.code }", gradient_width)
    end

    def self.render_name(pdf, first_name, last_name, company_name, padding, gradient_width)
      pdf.fill_color = "ffffff"
      total_name_width = gradient_width + pdf.width_of(last_name)
      if total_name_width > 2.in
        pdf.draw_text first_name, :at => [padding, 0.7.in], :size => 15
        pdf.fill_color = "000000"
        pdf.draw_text last_name, :at => [gradient_width + 0.02.in, 0.7.in], :size => 12
        pdf.draw_text company_name, :at => [gradient_width + 0.02.in, 0.5.in], :size => 10
      else
        pdf.draw_text first_name, :at => [padding, 0.7.in], :size => 15
        pdf.fill_color = "000000"
        pdf.draw_text last_name, :at => [gradient_width + 0.02.in, 0.7.in], :size => 15
        pdf.draw_text company_name, :at => [gradient_width + 0.02.in, 0.5.in], :size => 12
      end
    end

    def self.render_url(pdf, url, gradient_width)
      if gradient_width > 1.7.in
        pdf.draw_text url, :at => [1.85.in, 0.1.in], :size => 12
      elsif gradient_width > 1.5.in
        pdf.draw_text url, :at => [1.65.in, 0.1.in], :size => 13
      elsif gradient_width > 1.3.in
        pdf.draw_text url, :at => [1.5.in, 0.1.in], :size => 14
      elsif gradient_width > 1.1.in
        pdf.draw_text url, :at => [1.3.in, 0.1.in], :size => 15
      else
        pdf.draw_text url, :at => [1.2.in, 0.1.in], :size => 16
      end
    end

    def self.render_logo(pdf, logo)
      pdf.image logo, :at => [2.65.in, 0.95.in], :width => 0.75.in
    end
  end
end

