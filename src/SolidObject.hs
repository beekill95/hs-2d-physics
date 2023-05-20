module SolidObject where

import Vec

class SolidObject a where
  position :: a -> Vec
  updatePosition :: Vec -> a -> a

  velocity :: a -> Vec
  updateVelocity :: Vec -> a -> a

