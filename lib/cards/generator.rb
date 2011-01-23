require 'prawn'
require 'prawn/measurement_extensions'

module Cards
  class Generator
    def self.generate_card(data)
      # clean up color
      data[:color].gsub!(/#/,'')

      pdf = Prawn::Document.new :margin => 0, :page_size => [3.5.in, 2.in]
      $pageWidth = 3.5.in
      $pageHeight = 2.in

      self.render_card(pdf, data)

      pdf.render_file('./tmp/cards/preview.pdf')
    end

    protected

    def self.render_card(pdf, data)
      pdf.fill_color = "000000"
      pdf.draw_text data[:first_name], :at => [0,1.in], :size => 16.8

      pdf.fill_color = "000000"
      pdf.draw_text data[:last_name], :at => [0,0.5.in], :size => 16.8

      pdf.fill_color = data[:color]
      pdf.draw_text "http://conne.cc/#{ data[:code] }", :at => [0,0], :size => 18.8
    end
  end
end

