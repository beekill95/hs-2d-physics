module Container where

import qualified Graphics.Gloss as G
import Linear.V2
import Object
import Renderer

-- For simplicity, we will just define a circular container.

type Color = (Float, Float, Float, Float)

data Container = Container
  { center :: V2 Float,
    radius :: Float,
    color :: Color
  }

instance Renderable Container where
  render
    ( Container
        { center = (V2 x y),
          radius = rad,
          color = (r, g, b, a)
        }
      ) = G.color c $ G.translate x y $ G.circleSolid rad
      where
        c = G.makeColor r g b a

class (Movable a) => ContainerBouncer a where
  bounceOff :: Container -> a -> a
