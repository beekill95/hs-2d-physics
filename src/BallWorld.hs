module BallWorld where

import Ball
import Graphics.Gloss
import Renderer
import Solver
import Vec

data BallWorld = BallWorld
  { balls :: [Ball],
    boundary :: Int,
    g :: Vec
  }

instance VerletWorld BallWorld where
  gravity = g
  updateWorld t w = w {balls = objs}
    where
      objs = map (accelerate t w) $ balls w

instance Renderable BallWorld where
  render w = Pictures $ map render objs
    where
      objs = balls w
