module MyLib where

import Ball
import BallWorld
import qualified Graphics.Gloss as G
import Linear.V2
import Renderer
import World

initialWorld :: BallWorld
initialWorld =
  BallWorld
    { balls =
        [ Ball
            { center = V2 0 0,
              radius = 10,
              velocity = V2 0 0,
              acceleration = V2 0 (-50)
            }
        ],
      boundary = 0
    }

renderBallWorld :: BallWorld -> G.Picture
renderBallWorld = render

updateBallWorld :: Float -> BallWorld -> BallWorld
updateBallWorld = updateWorld
