module MyLib where

import qualified Ball as B
import BallWorld
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
            { B.center = V2 0 0,
              B.radius = 10,
              B.velocity = V2 0 0,
              B.acceleration = V2 0 (-50),
              B.color = G.white
            }
        ],
      container =
        C.Container
          { C.center = V2 0 0,
            C.radius = 250,
            C.color = G.black
          }
    }

renderBallWorld :: BallWorld -> G.Picture
renderBallWorld = render

updateBallWorld :: Float -> BallWorld -> BallWorld
updateBallWorld = updateWorld
