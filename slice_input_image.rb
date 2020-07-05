require "rmagick"
include Magick

def slice_image(image, num_slices)
  slice_height = image.rows / num_slices
  slice_width = image.columns / num_slices
  num_slices.times do |i|
    num_slices.times do |j|
      cropped_image = image.crop(i * slice_width, j * slice_height, slice_width, slice_height)
      cropped_image_path = "Input Tile Images/tile_#{i}_#{j}.jpg"
      cropped_image.write(cropped_image_path) { self.format = "jpg" }
    end
  end
end

