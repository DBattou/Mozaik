require 'rubygems'
require 'rmagick'
include Magick

puts "hello"
image = ImageList.new("http://www.larousse.fr/encyclopedie/data/images/1006415-Poney.jpg")
image.write("another_filename.jpg")

puts "This image is #{image.columns}x#{image.rows} pixels"
