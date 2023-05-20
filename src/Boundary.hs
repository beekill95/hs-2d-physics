module Boundary where

import SolidObject

class Boundary a where
  collide :: (SolidObject b) => a -> b -> b
