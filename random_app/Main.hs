module Main where

import Graphics.Gloss.Interface.IO.Simulate
import RandomAppLib

main :: IO ()
main = simulateIO window background fps initialWorld renderBallWorld update
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
    update _ = updateBallWorld