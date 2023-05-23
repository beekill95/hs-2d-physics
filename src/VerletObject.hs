module VerletObject where

import Object

class (Movable a) => VerletObject a where
  -- previousPosition_ :: a -> Maybe Vec2
  -- updatePreviousPosition :: Vec2 -> a -> a

  move :: Float -> a -> a
  move t o = (updateVelocity newV . updatePosition newPos) o
    where
      a = acceleration_ o
      p = position_ o

      -- Calculate new velocity.
      v = velocity_ o
      newV = v + a * pure t

      -- Calculate new position.
      newPos = p + (v * pure t) + 0.5 * a * pure (t * t)
