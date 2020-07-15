require "rmagick"
include Magick

def avg_rgb_for_folder(directory)
  array_of_rgb_values = []
  Dir.glob("#{directory}/*.jpg").sort.each do |filename|
    image = Image.read(filename).first
    array_of_rgb_values << [filename, calc_avg_rgb(image)]
  end
  return array_of_rgb_values
end

def calc_avg_rgb(image)
  total = 0
  avg = { :r => 0.0, :g => 0.0, :b => 0.0 }
  image.quantize.color_histogram.each { |c, n|
    avg[:r] += n * c.red
    avg[:g] += n * c.green
    avg[:b] += n * c.blue
    total += n
  }
  [:r, :g, :b].each { |comp| avg[comp] /= total }
  [:r, :g, :b].each { |comp| avg[comp] = (avg[comp] / QuantumRange * 255).to_i }
  return avg
end