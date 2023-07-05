module Main where

-- import Control.DeepSeq

-- import System.CPUTime

import Control.DeepSeq
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
      -- start <- getCPUTime
      -- newWorld <- updateBallWorld t w
      -- let balls = getBalls newWorld
      -- end <- balls `deepseq` getCPUTime
      -- let seconds = fromIntegral (end - start) * (10 ** (-12)) :: Float
      (seconds, newWorld) <- timeItT $ do
        x <- updateBallWorld t w
        return $!! x

      putStrLn $
        show (nbBalls newWorld)
          ++ " balls took "
          ++ show seconds
          ++ " seconds to update, but it should be less than "
          ++ show t
          ++ " seconds."
      return newWorld

    -- Measure render time.
    render w = do
      (seconds, picture) <- timeItT $ renderBallWorld w
      putStrLn $ "Rendering took " ++ show seconds ++ " seconds."
      return picture
