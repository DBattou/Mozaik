require 'rubygems'
require 'rmagick'
require 'json'
include Magick

# Read JSON from a file and extract parameters
file = File.read("output_format.json")
data_hash = JSON.parse(file)
name = data_hash["name"]
width = data_hash["width"]
height = data_hash["height"]
backgroundColor = data_hash["backgroundColor"]
inputImg = data_hash["inputImg"]
outputSize = data_hash["outputSize"]

# Create colored base frame
baseFrame = Image.new(width, height) { self.background_color = backgroundColor }

# Read image from URL, resize and compose
inputImg.each do |item|
	image = ImageList.new(item["URL"]).first
	resize_factor = item["percentSize"].to_f/100
	image.resize_to_fill!(width*resize_factor, height*resize_factor)
	baseFrame.composite!(image, item["x_position"].to_i, item["y_position"].to_i, Magick::OverCompositeOp)
end

# Print result
baseFrame.write(name)
puts "This image is #{baseFrame.columns}x#{baseFrame.rows} pixels"
