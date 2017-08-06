require 'rubygems'
require 'json'
require_relative 'mozaik'

# Test entry
if ARGV.empty?
  	puts "No argument provided. Usage: ruby mozaik.rb [ filename ] "
  	exit
elsif ARGV.length > 1
	puts "Too many arguments provided. Usage: ruby mozaik.rb [ filename ] "
  	exit
end

# Parse JSON file
infos = JSON.parse(File.read(ARGV[0]))

# Create Mozaik obj
mozaik = Mozaik.new(infos)

# Adding images to the mosaic
infos["inputImg"].each do |image|
	mozaik.add_mosaic_parts(image)
end

# Create the output image
finalImage = mozaik.render_final_image()

# Print result
finalImage.write(mozaik.get_name())
puts "The mosaic is #{finalImage.columns}x#{finalImage.rows} pixels"
