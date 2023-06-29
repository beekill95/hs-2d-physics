module Container where

import qualified Graphics.Gloss as G
import Linear.V2
import Renderer

-- For simplicity, we will just define a circular container.

data Container = Container
  { center :: V2 Float,
    radius :: Float,
    color :: G.Color
  }

instance Renderable Container where
  render (Container {center = (V2 x y), radius = r, color = c}) = G.color c $ G.translate x y $ G.circleSolid r
