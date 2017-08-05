require 'RMagick'
include Magick

cat = ImageList.new("Cheetah.jpg")
cat.display
exit