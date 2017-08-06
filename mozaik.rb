require 'rubygems'
require 'rmagick'
require 'json'
include Magick

ImgDetails = Struct.new(:name, :width, :height, :backgroundColor, :inputImg, :outputSize)

# Read JSON from a file and extract parameters
def read_input (file)
	data_hash = JSON.parse(File.read(file))
	name = data_hash["name"]
	width = data_hash["width"]
	height = data_hash["height"]
	backgroundColor = data_hash["backgroundColor"]
	inputImg = data_hash["inputImg"]
	outputSize = data_hash["outputSize"]
	return ImgDetails.new(name, width, height, backgroundColor, inputImg, outputSize)
end

inputData = read_input("input_informations.json")
p inputData.inputImg[0]["percentSize"]

# Create colored base for the final image
imageToPrint = Image.new(inputData.width, inputData.height) { self.background_color = inputData.backgroundColor }

# Read image from URL, resize and compose
inputData.inputImg.each do |item|
	imageToInsert = ImageList.new(item["URL"]).first
	resizeFactor = item["percentSize"].to_f/100
	imageToInsert.resize_to_fill!(inputData.width*resizeFactor, inputData.height*resizeFactor)
	imageToPrint.composite!(imageToInsert, item["x_position"].to_i, item["y_position"].to_i, Magick::OverCompositeOp)
end

# Print result
imageToPrint.write(inputData.name)
puts "This image is #{imageToPrint.columns}x#{imageToPrint.rows} pixels"
