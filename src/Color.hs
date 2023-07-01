module Color where

-- All of these values are in range [0, 1].
type RGBA = (Float, Float, Float, Float)

-- HSV values in range [0, 1]
type HSV = (Float, Float, Float)

-- From https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB
hsv_2_rgba :: HSV -> RGBA
hsv_2_rgba (h, s, v) = case hue_sector of
  y | 0 <= y && y < 1 -> (chroma + m, x + m, m, 1)
  y | 1 <= y && y < 2 -> (x + m, chroma + m, m, 1)
  y | 2 <= y && y < 3 -> (m, chroma + m, x + m, 1)
  y | 3 <= y && y < 4 -> (m, x + m, chroma + m, 1)
  y | 4 <= y && y < 5 -> (x + m, m, chroma + m, 1)
  _ -> (chroma + m, m, x + m, 1)
  where
    chroma = s * v
    hue_sector = h * 6
    x = chroma * (hue_sector - fromIntegral (round hue_sector :: Integer))
    m = v - x
