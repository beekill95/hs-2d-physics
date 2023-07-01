module RandomAppLib where

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
            { B.center = V2 200 0,
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
          }
    }

renderBallWorld :: BallWorld -> IO G.Picture
renderBallWorld w = return $ render w

updateBallWorld :: Float -> BallWorld -> IO BallWorld
updateBallWorld t w = return $ updateWorld t w
