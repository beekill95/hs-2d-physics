module Boundary where

import Objects

class Boundary a where
  collide :: (SolidObject b) => a -> b -> b
