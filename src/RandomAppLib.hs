module RandomAppLib where

import qualified Ball as B
import BallWorld
import CollisionsSolvers (solveCollisionsNaively)
import qualified Color (hsv_2_rgba)
import qualified Container as C
import Control.Monad.Random
import qualified Graphics.Gloss as G
import Linear.V2
import Renderer
import World

type Vec2 = V2 Float

initialWorld :: BallWorld
initialWorld =
  BallWorld
    { balls = [],
      container =
        C.Container
          { C.center = V2 0 0,
            C.radius = 500,
            C.color = (0, 0, 0, 1)
          },
      hsv = (0, 0.7, 0.65),
      timeSinceLastBall = 0,
      collisionsSolver = solveCollisionsNaively
    }

-- For showing information about the world.
nbBalls :: BallWorld -> Int
nbBalls = length . balls

generateRandomRadius :: (Float, Float) -> IO Float
generateRandomRadius = randomRIO

renderBallWorld :: BallWorld -> IO G.Picture
renderBallWorld = return . render

updateBallWorld :: Float -> BallWorld -> IO BallWorld
updateBallWorld t w =
  if timeElapsed < wait
    then update w {timeSinceLastBall = timeElapsed + t}
    else do
      randomRadius <- generateRandomRadius (5, 20)

      let -- Number of different ball colors.
          nbColors = 36

          -- Get current ball color.
          currentHSV@(h, s, v) = hsv w

          -- Generate a new ball.
          moreBalls =
            B.Ball
              { B.center = V2 150 150,
                B.acceleration = V2 0 (-50),
                B.velocity = V2 (-400) (-400),
                B.radius = randomRadius,
                B.color = Color.hsv_2_rgba currentHSV,
                B.previousCenter = Nothing
              }
              : balls w

          -- Update the color for the next ball.
          nextHue = h + (nbColors / 360)
          nextHSV = (if nextHue < 1 then nextHue else nextHue - 1, s, v)

      update w {balls = moreBalls, hsv = nextHSV, timeSinceLastBall = 0}
  where
    -- Time to wait before adding a new ball.
    wait = 0.1

    -- Time since adding a new ball.
    timeElapsed = timeSinceLastBall w

    -- Shortcut to update the world after the given time
    -- and return IO world.
    update = return . updateWorld t
