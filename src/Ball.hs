module Ball where

import qualified Graphics.Gloss as G
import Linear.V2
import Renderer
import SolidObject
import Vec

data Ball = Ball
  { center :: Vec,
    radius :: Float,
    vel :: Vec,
    color :: G.Color
  }

instance SolidObject Ball where
  position = center
  updatePosition pos ball = ball {center = pos}

  velocity = vel
  updateVelocity v ball = ball {vel = v}

instance Renderable Ball where
  render b = G.color c $ G.translate x y $ G.circleSolid r
    where
      r = radius b
      c = color b
      (V2 x y) = center b
