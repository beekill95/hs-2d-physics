module Main where

import Graphics.Gloss.Interface.IO.Simulate
import RandomAppLib
import System.TimeIt

main :: IO ()
main = simulateIO window background fps initialWorld render update
  where
    -- Window's width, height, and offset.
    width, height, offset :: Int
    width = 1000
    height = 1000
    offset = 200

    -- Frames per second.
    fps :: Int
    fps = 60

    -- Window to draw our simulation.
    window = InWindow "Ball World" (width, height) (offset, offset)

    -- Window's background color.
    background = black

    -- Update world.
    update _ t w = do
      (seconds, newWorld) <- timeItT $ updateBallWorld t w
      putStrLn $ show (nbBalls newWorld) ++ " balls took " ++ show seconds ++ " seconds to update."
      return newWorld

    -- Measure render time.
    render w = do
      (seconds, picture) <- timeItT $ renderBallWorld w
      putStrLn $ "Rendering took " ++ show seconds ++ " seconds."
      return picture
