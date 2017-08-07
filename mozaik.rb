require 'rubygems'
require 'rmagick'
include Magick


class Mozaik

    attr_accessor :name

    def initialize (infos)
        @name = test_input(infos["name"], "DefaultName.jpg")
        @width = test_input(infos["width"], 100)
        @height = test_input(infos["height"], 100)
        @backgroundColor = test_input(infos["backgroundColor"], "blue")
        @baseFrame = Image.new(@width, @height) { self.background_color =  @backgroundColor.to_s }
        @mozaikParts = infos["inputImg"]
        @outputSize = test_input(infos["outputSize"], 50)
    end

    def test_input(var, default)
        if var.class == String
            if var.empty?
                return default
            end
        end
        if var.nil? || var == 0
            return default
        end
        return var
    end

    def render_final_image
        @mozaikParts.each do |mosaicPart|
            image = ImageList.new(mosaicPart["URL"]).first
            factor = mosaicPart["percentSize"].to_f/100
            image.resize_to_fill!(@width*factor, @height*factor)
            @baseFrame.composite!(image, mosaicPart["x_pos"].to_i, mosaicPart["y_pos"].to_i,  Magick::OverCompositeOp)
        end
        return @baseFrame
    end
end
