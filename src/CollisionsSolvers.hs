module CollisionsSolvers where

import Object

solveCollisionsNaively :: (RigidObject a) => [a] -> [a]
solveCollisionsNaively [] = []
solveCollisionsNaively (x : xs) = xNew `seq` xNew : solveCollisionsNaively xsNew
  where
    solveCollisions y [] = (y, [])
    solveCollisions y (h : rest) = y2 `seq` (y2, h1 : rest2)
      where
        (y1, h1) = solveCollision y h
        (y2, rest2) = y1 `seq` solveCollisions y1 rest

    (xNew, xsNew) = solveCollisions x xs
