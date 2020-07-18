require "./slice_input_image.rb"
require "./calc_avg_rgb.rb"
require "./converter.rb"

panda = Image.read("InputImages/panda-4k.jpg").first
slice_image(panda, 20)

rgb_values_for_replacement_images = avg_rgb_for_folder("TileReplacementImages")

tile_images = Dir.glob("InputTileImages/*.jpg").sort.map do |filename|
  image = Image.read(filename).first
  rgb = calc_avg_rgb(image)
  filename, = rgb_values_for_replacement_images.min do |(_, rgb1), (_, rgb2)|
    d1 = color_distance(rgb,rgb1)
    d2 = color_distance(rgb, rgb2)
    d1 <=> d2
  end

  filename
end

not_sized_images = Magick::ImageList.new(*tile_images)
not_sized_images.each do |img|
  img.resize_to_fill!(192,108)
end

montage_image = not_sized_images.montage do 
  self.tile = "20x20"
  self.geometry = Magick::Geometry.new(192, 108, 0, 0)
end

montage_image.write("Mosaic.jpg")
montage_image.display

