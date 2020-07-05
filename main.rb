require "./slice_input_image.rb"
require "./calc_avg_rgb.rb"

panda = ImageList.new("Input Images/panda-4k.jpg")
slice_image(panda, 20)

rgb_values_for_rgb_images_folder = avg_rgb_for_folder("RGB Images")
rgb_values_for_tile_images_folder = avg_rgb_for_folder("Input Tile Images")

print rgb_values_for_rgb_images_folder
print "\n"
print rgb_values_for_tile_images_folder


panda.display
