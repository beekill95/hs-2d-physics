module Object where

import Linear.Metric
import Linear.V2

type Vec2 = V2 Float

class Object a where
  position_ :: a -> Vec2

class (Object a) => Movable a where
  velocity_ :: a -> Vec2
  acceleration_ :: a -> Vec2

  updatePosition :: Vec2 -> a -> a
  updateVelocity :: Vec2 -> a -> a
  updateAcceleration :: Vec2 -> a -> a

class (Movable a) => RigidCircular a where
  radius_ :: a -> Float

  isCollided :: a -> a -> Bool
  isCollided o1 o2 = d <= (r1 + r2)
    where
      d = distance (position_ o1) (position_ o2)
      r1 = radius_ o1
      r2 = radius_ o2

  solveCollision :: a -> a -> (a, a)
  solveCollision o1 o2 = _
    where
      p1 = position_ o1
      p2 = position_ o2

      d = distance p1 p2
      r1 = radius_ o1
      r2 = radius_ o2
