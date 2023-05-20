module Renderer where

import Graphics.Gloss

class Renderable a where
  render :: a -> Color -> Picture
