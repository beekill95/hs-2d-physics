module Objects where

import Vec

class SolidObject a where
  position :: a -> Vec
  updatePosition :: Vec -> a -> a

  velocity :: a -> Vec
  updateVelocity :: Vec -> a -> a

data Ball = Ball
  { center :: Vec,
    radius :: Float,
    vel :: Vec
  }

instance SolidObject Ball where
  position = center
  updatePosition pos ball = ball {center = pos}

  velocity = vel
  updateVelocity v ball = ball {vel = v}
