module Container where

import qualified Color
import Control.DeepSeq
import GHC.Generics (Generic)
import qualified Graphics.Gloss as G
import Linear.V2
import Object
import Renderer

-- For simplicity, we will just define a circular container.

data Container = Container
  { center :: V2 Float,
    radius :: Float,
    color :: Color.RGBA
  }
  deriving (Generic)

instance NFData Container

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
