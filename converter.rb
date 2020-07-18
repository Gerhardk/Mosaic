
X_n = 0.950489 
Y_n = 1.00 
Z_n = 1.088840
K1 = 0.045
K2 = 0.015

def gamma_inverse(u)
  if u < 0.04045
    u / 12.92
  else
    ((u + 0.055) / 1.055)**2.4
  end
end

def convert_srgb_to_rgb(srgb)
  srgb.transform_values { |u|
    gamma_inverse(u/255.0)
  }
end

def convert_rgb_to_xyz(rgb)
  r, g, b = rgb.values_at(:r, :g, :b)

  m00 = 0.41239080; m01 = 0.35758434; m02 = 0.18048079
  m10 = 0.21263901; m11 = 0.71516868; m12 = 0.07219232
  m20 = 0.01933082; m21 = 0.11919478; m22 = 0.95053215

  x = m00 * r + m01 * g + m02 * b
  y = m10 * r + m11 * g + m12 * b
  z = m20 * r + m21 * g + m22 * b

  {x: x, y: y, z: z}
end

def f(t)
  if t > 0.008856451679035631
    t ** (1.0/3)
  else
    t * 11.680555555555555 + 0.13793103448275862
  end
end

def convert_xyz_to_lab(xyz)
  x, y, z = xyz.values_at(:x, :y, :z)
  fy = f(y/Y_n)
  l = 116.0 * fy - 16.0
  a = 500.0 * (f(x/X_n) - fy)
  b = 200.0 * (fy- f(z/Z_n))

  {l: l, a: a, b: b }
end

def cielab_distance(value_1, value_2)
  l1, a1, b1 = value_1.values_at(:l, :a, :b)
  l2, a2, b2 = value_2.values_at(:l, :a, :b)

  dl = l1 - l2
  da = a1 - a2
  db = b1 - b2
  # dE2 = (l2 - l1)**2 + (a2 - a1)**2 + (b2 - b1)**2


  c1 = Math.sqrt(a1**2 + b1**2)
  c2 = Math.sqrt(a2**2 + b2**2)
  dcab = c1 - c2
  dhab = Math.sqrt(da**2 + db**2 - dcab**2)
  sc = 1.0 + K1*c1
  sh = 1.0 + K2*c1

  Math.sqrt(dl**2 + (dcab/sc)**2 + (dhab/sh)**2)
end

def convert_srgb_to_lab(srgb)
  rgb = convert_srgb_to_rgb(srgb)
  xyz = convert_rgb_to_xyz(rgb)
  convert_xyz_to_lab(xyz)
end

def color_distance(value_1, value_2)
  lab1 = convert_srgb_to_lab(value_1)
  lab2 = convert_srgb_to_lab(value_2)
  cielab_distance(lab1, lab2)
end

# def rgb_distance_sq(value_1, value_2)
#   r1, g1, b1 = value_1.values_at(:r, :g, :b)
#   r2, g2, b2 = value_2.values_at(:r, :g, :b)
#   rd = r1 - r2
#   gd = g1 - g2
#   bd = b1 - b2

#   rd**2 + gd**2 + bd**2
# end