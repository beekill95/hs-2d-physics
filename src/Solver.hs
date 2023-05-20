module Solver where

import Objects
import Vec

data World = World
  { objects :: [Ball],
    boundary :: Int,
    gravity :: Vec
  }
