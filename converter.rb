
def convert_rgb_to_xyz(rgb)

end

def convert_xyz_to_lab(xyz)

end

def rgb_distance_sq(value_1, value_2)
  r1, g1, b1 = value_1.values_at(:r, :g, :b)
  r2, g2, b2 = value_2.values_at(:r, :g, :b)
  rd = r1 - r2
  gd = g1 - g2
  bd = b1 - b2

  rd**2 + gd**2 + bd**2
end