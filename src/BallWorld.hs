module BallWorld where

import Ball
import CollisionsSolvers (solveCollisionsNaively)
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
  updateWorld t w = w {balls = update w}
    where
      moveBalls world = map (move t) (balls world)
      bounceOffContainer = map $ bounceOff $ container w

      update = solveCollisionsNaively . bounceOffContainer . moveBalls

instance Renderable BallWorld where
  render w = Pictures p
    where
      p = render (container w) : map render (balls w)
