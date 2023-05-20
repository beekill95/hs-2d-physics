module Objects where

import Vec

class SolidObject a where
  position :: a -> Vec
  updatePosition :: a -> Vec -> a

data Ball = Ball
  { center :: Vec,
    radius :: Float
  }

instance SolidObject Ball where
  position = center
  updatePosition ball pos = ball {center = pos}
