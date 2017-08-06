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

# Read image from URL
def read_url_image(adress)
	return ImageList.new(adress).first
end

# Resize image
def resize_image(image, width, height)
	return image.resize_to_fill(width, height)
end

# Insert image into base frame
def insert_image(baseImage, imageToInsert, x_position, y_position)
	return baseImage.composite(imageToInsert, x_position, y_position, Magick::OverCompositeOp)
end


# Extract data from the input file
inputData = read_input("input_info.json")

# Create colored base for the final image
finalImage = Image.new(inputData.width, inputData.height) { self.background_color = inputData.backgroundColor }

# Read image from URL, resize and compose
inputData.inputImg.each do |item|
	imageToInsert = read_url_image(item["URL"])
	factor = item["percentSize"].to_f/100
	width = inputData.width*factor
	height = inputData.height*factor
	imageToInsert = resize_image(imageToInsert, width, height)
	finalImage = insert_image(finalImage, imageToInsert, item["x_position"].to_i, item["y_position"].to_i)
end

# Print result
finalImage.write(inputData.name)
finalImage.display
