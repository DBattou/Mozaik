require 'rubygems'
require 'rmagick'
require 'json'
include Magick


# Read JSON from a file, iterate over objects
file = File.read("output_format.json")
data_hash = JSON.parse(file)

# Extract paramaters
m_name = data_hash["name"]
m_width = data_hash["width"]
m_height = data_hash["height"]
m_backgroundColor = data_hash["backgroundColor"]
m_inputImg = data_hash["inputImg"]
m_outputSize = data_hash["outputSize"]


# Read image from URL
m_inputImg.each do |item|
	p item["URL"]
end
image = ImageList.new("http://www.larousse.fr/encyclopedie/data/images/1006415-Poney.jpg").first


# Print result
image.write("another_filename.jpg")
puts "This image is #{image.columns}x#{image.rows} pixels"
