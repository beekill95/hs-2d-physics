module RandomAppLib where

import qualified Ball as B
import BallWorld
import qualified Color (hsv_2_rgba)
import qualified Container as C
import qualified Graphics.Gloss as G
import Linear.V2
import Renderer
import World

initialWorld :: BallWorld
initialWorld =
  BallWorld
    { balls = [],
      container =
        C.Container
          { C.center = V2 0 0,
            C.radius = 250,
            C.color = (0, 0, 0, 1)
          },
      hsv = (0, 0.7, 0.65),
      timeSinceLastBall = 0
    }

renderBallWorld :: BallWorld -> IO G.Picture
renderBallWorld = return . render

updateBallWorld :: Float -> BallWorld -> IO BallWorld
updateBallWorld t w =
  return $
    updateWorld
      t
      ( if timeElapsed < wait
          then w {timeSinceLastBall = timeElapsed + t}
          else w {balls = moreBalls, hsv = nextHSV, timeSinceLastBall = 0}
      )
  where
    -- Time to wait before adding a new ball.
    wait = 1

    -- Time since adding a new ball.
    timeElapsed = timeSinceLastBall w

    -- Number of different ball colors.
    nbColors = 36

    -- Get current ball color.
    currentHSV@(h, s, v) = hsv w

    -- Generate a new ball.
    moreBalls =
      B.Ball
        { B.center = V2 150 150,
          B.acceleration = V2 0 (-50),
          B.velocity = V2 0 0,
          -- TODO: will be changed to random radius later on.
          B.radius = 10,
          B.color = Color.hsv_2_rgba currentHSV,
          B.previousCenter = Nothing
        }
        : balls w

    -- Update the color for the next ball.
    nextHue = h + (nbColors / 360)
    nextHSV = (if nextHue < 1 then nextHue else nextHue - 1, s, v)
