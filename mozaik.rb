require 'rubygems'
require 'rmagick'
include Magick


class Mozaik
	def initialize (infos)
		@name = infos["name"]
		@width = infos["width"]
		@height = infos["height"]
		@baseFrame = Image.new(@width, @height) { self.background_color = infos["backgroundColor"] }
		@mozaikParts = Array.new
		@outputSize = infos["outputSize"]
	end
	def add_mosaic_parts(image)
		@mozaikParts << image
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
	def get_name
		return @name
	end
end

