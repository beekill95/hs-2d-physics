module BallWorld where

import Ball
import Container
import Graphics.Gloss
import Object (RigidShape (solveCollision))
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

      update = solveCollisions . bounceOffContainer . moveBalls

instance Renderable BallWorld where
  render w = Pictures p
    where
      p = render (container w) : map render (balls w)

-- FIXME: move this to CollisionsSolvers module
-- and abstract this to work with RigidShape;
-- and better naming.
solveCollisions :: [Ball] -> [Ball]
solveCollisions [] = []
solveCollisions (h : rest) = hNew : solveCollisions restNew
  where
    (hNew, restNew) = individuallySolveCollisions h rest

individuallySolveCollisions :: Ball -> [Ball] -> (Ball, [Ball])
individuallySolveCollisions x [] = (x, [])
individuallySolveCollisions x (h : rest) = (x2, hNew : restNew)
  where
    (x1, hNew) = solveCollision x h
    (x2, restNew) = individuallySolveCollisions x1 rest
