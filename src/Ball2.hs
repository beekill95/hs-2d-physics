{-# LANGUAGE MultiParamTypeClasses #-}

module Ball2 where

import Graphics.Gloss
import Linear.V2
import Object
import Renderer
import VerletObject

data Ball2 = Ball2
  { center :: Vec2,
    radius :: Float,
    velocity :: Vec2,
    acceleration :: Vec2
  }

data Rectangle2 = R {a :: Float, b :: Float}

instance Object Rectangle2 where
  position_ = undefined

instance Object Ball2 where
  position_ = center

instance Movable Ball2 where
  velocity_ = velocity
  acceleration_ = acceleration

  updatePosition p o = o {center = p}
  updateVelocity v o = o {velocity = v}
  updateAcceleration a o = o {acceleration = a}

instance VerletObject Ball2

instance Renderable Ball2 where
  render (Ball2 {center = (V2 x y), radius = r}) = translate x y $ circleSolid r

-- instance RigidShape Ball2 Ball2 where
--   isCollided _ _ = True

-- instance RigidShape Ball2 Rectangle2 where
--   isCollided _ _ = True

-- instance RigidShape Rectangle2 Ball2 where
--   isCollided = flip isCollided
