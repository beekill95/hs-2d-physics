module VerletObject where

import Object

-- From: https://www.algorithm-archive.org/contents/verlet_integration/verlet_integration.html
class (Movable a) => VerletObject a where
  move :: Float -> a -> a
  move t o = (updateVelocity newV . updatePosition newPos) o
    where
      a = acceleration_ o
      p = position_ o

      -- Calculate velocity at half timestep.
      v_half_timestep = velocity_ o + a * pure (0.5 * t)

      -- Calculate new position.
      newPos = p + v_half_timestep * pure t

      -- Calculate new velocity.
      newV = v_half_timestep + a * pure (0.5 * t)
