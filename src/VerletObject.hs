module VerletObject where

import Object

-- From: https://www.algorithm-archive.org/contents/verlet_integration/verlet_integration.html
class (Movable a) => VerletObject a where
  previousPosition_ :: a -> Maybe Vec2
  updatePreviousPosition :: Vec2 -> a -> a

  move :: Float -> a -> a
  move t obj = case previousPosition_ obj of
    Just prevPos -> stormerVerlet prevPos obj
    Nothing -> velocityVerlet obj
    where
      updateObj vel pos prevPos = updateVelocity vel . updatePosition pos . updatePreviousPosition prevPos

      -- If we don't have the previous position, just use the velocity verlet equations.
      velocityVerlet o = updateObj newVel newPos p o
        where
          a = acceleration_ o
          p = position_ o

          -- Calculate velocity at half timestep.
          v_half_timestep = velocity_ o + a * pure (0.5 * t)

          -- Calculate new position.
          newPos = p + v_half_timestep * pure t

          -- Calculate new velocity.
          newVel = v_half_timestep + a * pure (0.5 * t)

      -- Otherwise, we can use the verlet and stormer-verlet equations.
      stormerVerlet prevPos o = updateObj newVel newPos p o
        where
          a = acceleration_ o
          p = position_ o

          -- Calculate the new position.
          newPos = pure 2 * p - prevPos + a * pure (t * t)

          -- Calculate the new velocity.
          newVel = (newPos - p) / pure t
