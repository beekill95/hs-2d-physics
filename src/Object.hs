{-# LANGUAGE MultiParamTypeClasses #-}

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

class (Movable a) => RigidShape a where
  isCollided :: a -> a -> Bool
  solveCollision :: a -> a -> (a, a)

class (RigidShape a, RigidShape b) => RigidShapePair a b where
  isCollidedPair :: a -> b -> Bool
  isCollidedPair a b = isCollidedPair' b a

  solveCollisionPair :: a -> b -> (a, b)
  solveCollisionPair a b = solveCollisionPair' b a

  isCollidedPair' :: b -> a -> Bool
  isCollidedPair' b a = isCollidedPair a b

  solveCollisionPair' :: b -> a -> (a, b)
  solveCollisionPair' b a = solveCollisionPair a b
