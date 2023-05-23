module BallWorld where

import Ball2
import Graphics.Gloss
import Renderer
import VerletObject
import World

data BallWorld = BallWorld
  { balls :: [Ball2],
    boundary :: Int
  }

instance World BallWorld where
  updateWorld t w = w {balls = objs}
    where
      objs = map (move t) $ balls w

instance Renderable BallWorld where
  render = Pictures . map render . balls
