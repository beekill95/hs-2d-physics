{-# LANGUAGE MultiParamTypeClasses #-}

module Ball where

import Graphics.Gloss
import Linear.V2
import Object
import Renderer
import VerletObject

data Ball = Ball
  { center :: Vec2,
    radius :: Float,
    velocity :: Vec2,
    acceleration :: Vec2
  }

instance Object Ball where
  position_ = center

instance Movable Ball where
  velocity_ = velocity
  acceleration_ = acceleration

  updatePosition p o = o {center = p}
  updateVelocity v o = o {velocity = v}
  updateAcceleration a o = o {acceleration = a}

instance VerletObject Ball

instance Renderable Ball where
  render (Ball {center = (V2 x y), radius = r}) = translate x y $ circleSolid r

-- instance RigidShape Ball2 Ball2 where
--   isCollided _ _ = True

-- instance RigidShape Ball2 Rectangle2 where
--   isCollided _ _ = True

-- instance RigidShape Rectangle2 Ball2 where
--   isCollided = flip isCollided
