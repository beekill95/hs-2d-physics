module SimpleAppLib where

import qualified Ball as B
import BallWorld
import CollisionsSolvers
import qualified Container as C
import qualified Graphics.Gloss as G
import Linear.V2
import Renderer
import World

initialWorld :: BallWorld
initialWorld =
  BallWorld
    { balls =
        [ B.Ball
            { B.center = V2 200 0,
              B.radius = 10,
              B.velocity = V2 0 0,
              B.acceleration = V2 0 (-50),
              B.color = (1, 1, 1, 1),
              B.previousCenter = Nothing
            },
          B.Ball
            { B.center = V2 (-200) 0,
              B.radius = 10,
              B.velocity = V2 0 0,
              B.acceleration = V2 0 (-50),
              B.color = (1, 1, 1, 1),
              B.previousCenter = Nothing
            },
          B.Ball
            { B.center = V2 (-125) 200,
              B.radius = 10,
              B.velocity = V2 0 0,
              B.acceleration = V2 0 (-50),
              B.color = (1, 1, 1, 1),
              B.previousCenter = Nothing
            },
          B.Ball
            { B.center = V2 125 200,
              B.radius = 10,
              B.velocity = V2 0 0,
              B.acceleration = V2 0 (-50),
              B.color = (1, 1, 1, 1),
              B.previousCenter = Nothing
            }
        ],
      container =
        C.Container
          { C.center = V2 0 0,
            C.radius = 250,
            C.color = (0, 0, 0, 1)
          },
      hsv = (0, 0, 0),
      timeSinceLastBall = 0,
      collisionsSolver = solveCollisionsNaively
    }

renderBallWorld :: BallWorld -> G.Picture
renderBallWorld = render

updateBallWorld :: Float -> BallWorld -> BallWorld
updateBallWorld = updateWorld
