require 'rubygems'
require 'json'
require_relative 'mozaik'

# Test entry
if ARGV.length != 1
    puts "Wrong numer of arguments provided. Usage: ruby mozaik.rb 'filename'"
    exit
end

# Parse JSON file
infos = JSON.parse(File.read(ARGV[0]))

# Create Mozaik obj
mozaik = Mozaik.new(infos)

# Create the output image
finalImage = mozaik.render_final_image()

# Print result
if mozaik.name.split(//).last(4).join != ".jpg"
    raise "The output format is wrong. Must be \".jpg\" "
else
    finalImage.write(mozaik.name)
    puts "The mosaic #{mozaik.name} is #{finalImage.columns}x#{finalImage.rows} pixels"
end

