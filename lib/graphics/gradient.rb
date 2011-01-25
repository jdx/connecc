require "RMagick"
include Magick

module Graphics
  class Gradient
    def initialize(width, color1, color2)
      color1 = "#" + color1
      color2 = "#" + color2
      gradient = GradientFill.new(0, 0, width, 2, color1, color2)
      @image = Image.new(width, 1, gradient)
      @image.format = 'PNG'
    end

    def read
      @image.to_blob
    end
  end
end
