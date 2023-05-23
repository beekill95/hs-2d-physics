module Object where

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
