module Solver where

import SolidObject
import Vec

class VerletWorld a where
  gravity :: a -> Vec

  updateWorld :: Float -> a -> a

  accelerate :: (SolidObject b) => Float -> a -> b -> b
  accelerate t w o = updateVelocity newV $ updatePosition newPos o
    where
      g = gravity w
      pos = position o

      -- Calculate new velocity.
      v = velocity o
      newV = v + g * pure t

      -- Calculate new position.
      newPos = pos + (v * pure t) + 0.5 * g * pure (t * t)
