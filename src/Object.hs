{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances #-}

module Object where

import Data.Tuple
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

class (Object a, Object b) => RigidShape a b where
  isCollided :: a -> b -> Bool
  solveCollision :: a -> b -> (a, b)

instance (Object a, Object b, RigidShape a b) => RigidShape b a where
  isCollided = flip isCollided
  solveCollision a b = swap $ solveCollision b a
