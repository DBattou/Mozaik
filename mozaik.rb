require 'rubygems'
require 'rmagick'
require 'json'
include Magick

# Read JSON from a file and extract parameters
file = File.read("output_format.json")
data_hash = JSON.parse(file)
m_name = data_hash["name"]
m_width = data_hash["width"]
m_height = data_hash["height"]
m_backgroundColor = data_hash["backgroundColor"]
m_inputImg = data_hash["inputImg"]
m_outputSize = data_hash["outputSize"]

# Create colored base frame
m_baseFrame = Image.new(m_width, m_height) { self.background_color = m_backgroundColor }

# Read image from URL, resize and compose
m_inputImg.each do |item|
	m_image = ImageList.new(item["URL"]).first
	m_image.resize_to_fill!(m_width*(item["percentSize"].to_f/100), m_height*(item["percentSize"].to_f/100))
	m_baseFrame.composite!(m_image, item["x_position"].to_i, item["y_position"].to_i, Magick::OverCompositeOp)
end

# Print result
m_baseFrame.write(m_name)
puts "This image is #{m_baseFrame.columns}x#{m_baseFrame.rows} pixels"
