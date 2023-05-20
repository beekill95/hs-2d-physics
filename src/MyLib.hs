module MyLib where

import Ball
import BallWorld
import qualified Graphics.Gloss as G
import Linear.V2
import Renderer
import Solver

initialWorld :: BallWorld
initialWorld =
  BallWorld
    { balls =
        [ Ball
            { center = V2 0 0,
              radius = 10,
              vel = V2 0 0,
              color = G.blue
            }
        ],
      boundary = 0,
      g = V2 0 (-50)
    }

renderBallWorld :: BallWorld -> G.Picture
renderBallWorld = render

updateBallWorld :: Float -> BallWorld -> BallWorld
updateBallWorld = updateWorld
