require 'prawn'
require 'prawn/fast_png'
require 'prawn/measurement_extensions'

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

          pdf.grid.show_all unless Rails.env.production?

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

        self.render_guides(pdf)

        pdf.start_new_page if cards[index]
      end
      return pdf
    end

    protected

    def self.render_guides(pdf)
      # prints guides for perforating
      pdf.stroke_color = "ff00000"
      pdf.stroke do
        # left side
        pdf.line [0, 9.5.in, 0.65.in, 9.5.in]
        pdf.line [0, 7.5.in, 0.65.in, 7.5.in]
        pdf.line [0, 5.5.in, 0.65.in, 5.5.in]
        pdf.line [0, 3.5.in, 0.65.in, 3.5.in]
        pdf.line [0, 1.5.in, 0.65.in, 1.5.in]

        # right side
        pdf.line [7.85.in, 9.5.in, 8.5.in, 9.5.in]
        pdf.line [7.85.in, 7.5.in, 8.5.in, 7.5.in]
        pdf.line [7.85.in, 5.5.in, 8.5.in, 5.5.in]
        pdf.line [7.85.in, 3.5.in, 8.5.in, 3.5.in]
        pdf.line [7.85.in, 1.5.in, 8.5.in, 1.5.in]
      end

      # prints guides for cutting
      pdf.stroke_color = "00ff00"
      pdf.stroke do
        # left side
        pdf.line [0, 10.5.in, 0.65.in, 10.5.in]
        pdf.line [0, 8.5.in, 0.65.in, 8.5.in]
        pdf.line [0, 6.5.in, 0.65.in, 6.5.in]
        pdf.line [0, 4.5.in, 0.65.in, 4.5.in]
        pdf.line [0, 2.5.in, 0.65.in, 2.5.in]
        pdf.line [0, 0.5.in, 0.65.in, 0.5.in]

        # right side
        pdf.line [7.85.in, 10.5.in, 8.5.in, 10.5.in]
        pdf.line [7.85.in, 8.5.in, 8.5.in, 8.5.in]
        pdf.line [7.85.in, 6.5.in, 8.5.in, 6.5.in]
        pdf.line [7.85.in, 4.5.in, 8.5.in, 4.5.in]
        pdf.line [7.85.in, 2.5.in, 8.5.in, 2.5.in]
        pdf.line [7.85.in, 0.5.in, 8.5.in, 0.5.in]

        # center
        pdf.line [4.25.in, 0.in, 4.25.in, 0.4.in]
        pdf.line [4.25.in, 11.in, 4.25.in, 10.6.in]

        # sides
        pdf.line [0.75.in, 0.in, 0.75.in, 0.4.in]
        pdf.line [0.75.in, 11.in, 0.75.in, 10.6.in]
        pdf.line [7.75.in, 0.in, 7.75.in, 0.4.in]
        pdf.line [7.75.in, 11.in, 7.75.in, 10.6.in]
      end
    end

    def self.render_card(pdf, data, card)

      # Set where the first name should start
      padding = 0.2.in

      # If the name is really short, give us some extra padding
      if padding + pdf.width_of(data[:first_name], :size => 15) < 1.in
        padding = 0.4.in
      end

      # get the width of the colored rectangle
      fill_width = padding + pdf.width_of(data[:first_name], :size => 15)
      pdf.fill_color = "124891"


      # fill the rectangle
      pdf.rectangle [0, 1.in], fill_width, 1.in
      pdf.fill

      # insert our data
      self.render_name(pdf, data[:first_name], data[:last_name], data[:company_name], padding, fill_width)
      self.render_logo(pdf, "#{ Rails.root.to_s }/lib/assets/logo.2.png")
      self.render_url(pdf, "http://conne.cc/#{ card.code }", fill_width)
    end

    def self.render_name(pdf, first_name, last_name, company_name, padding, fill_width)
      pdf.fill_color = "ffffff"
      total_name_width = fill_width + pdf.width_of(last_name)
      if total_name_width > 2.in
        pdf.draw_text first_name, :at => [padding, 0.7.in], :size => 15
        pdf.fill_color = "000000"
        pdf.draw_text last_name, :at => [fill_width, 0.7.in], :size => 12
        pdf.draw_text company_name, :at => [fill_width + 0.02.in, 0.5.in], :size => 6
      else
        pdf.draw_text first_name, :at => [padding, 0.7.in], :size => 15
        pdf.fill_color = "000000"
        pdf.draw_text last_name, :at => [fill_width, 0.7.in], :size => 15
        pdf.draw_text company_name, :at => [fill_width + 0.02.in, 0.5.in], :size => 8
      end
    end

    def self.render_url(pdf, url, fill_width)
      if fill_width > 1.7.in
        pdf.draw_text url, :at => [1.82.in, 0.1.in], :size => 12
      elsif fill_width > 1.5.in
        pdf.draw_text url, :at => [1.65.in, 0.1.in], :size => 13
      elsif fill_width > 1.3.in
        pdf.draw_text url, :at => [1.5.in, 0.1.in], :size => 14
      elsif fill_width > 1.1.in
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

