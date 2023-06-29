module BallWorld where

import Ball
import Container
import Graphics.Gloss
import Renderer
import VerletObject
import World

data BallWorld = BallWorld
  { balls :: [Ball],
    container :: Container
  }

instance World BallWorld where
  updateWorld t w = w {balls = objs}
    where
      objs = map (move t) $ balls w

instance Renderable BallWorld where
  render w = Pictures p
    where
      p = render (container w) : map render (balls w)
