module World where

class World a where
  updateWorld :: Float -> a -> a
