module CollisionsSolvers (solveCollisionsNaively, solveCollisionsGriddedly) where

import qualified Data.Map as M
import Linear.V2
import Object

-- Brute-force version of collisions solver.
solveCollisionsNaively :: (RigidObject a) => [a] -> [a]
solveCollisionsNaively [] = []
solveCollisionsNaively (x : xs) = xNew `seq` xNew : solveCollisionsNaively xsNew
  where
    solveCollisions y [] = (y, [])
    solveCollisions y (h : rest) = y2 `seq` (y2, h1 : rest2)
      where
        (y1, h1) = solveCollision y h
        (y2, rest2) = y1 `seq` solveCollisions y1 rest

    (xNew, xsNew) = solveCollisions x xs

-- Gridded version of collisions solver.
solveCollisionsGriddedly :: (RigidObject a) => (Int, Int) -> (Int, Int) -> Int -> [a] -> [a]
solveCollisionsGriddedly _ _ _ [] = []
solveCollisionsGriddedly w h s objs = (M.foldr (++) [] . cells) solvedGrid
  where
    solveCollisionsAndAccumulate ::
      (RigidObject a) =>
      (Int, Int, Cell a) ->
      (Cell a, [(Int, Int, Cell a)]) ->
      (Cell a, [(Int, Int, Cell a)])
    solveCollisionsAndAccumulate (r, c, neighbor) (cell, xs) = (cellSolved, (r, c, neighborSolved) : xs)
      where
        (cellSolved, neighborSolved) = solveCollisionsBetweenCells cell neighbor

    solveCollisionsForCell ::
      (RigidObject a) =>
      (Int, Int) ->
      CollisionsGrid a ->
      CollisionsGrid a
    solveCollisionsForCell (r, c) g = case getCell r c g of
      Nothing -> g
      Just cell -> foldr updateCell g updatedCells
        where
          neighboringCells = getNeighboringCells r c g

          -- First, solve collisions in the cell.
          cell1 = solveCollisionsNaively cell

          -- Then, solve collisions with neighboring cells.
          (cell2, neighboringCells2) = foldr solveCollisionsAndAccumulate (cell1, []) neighboringCells

          -- Collect the results.
          updatedCells = (r, c, cell2) : neighboringCells2

          -- Update these cells in the grid.
          updateCell (rCell, cCell, newCell) gr = case cellIdx rCell cCell gr of
            Nothing -> gr
            Just cIdx -> grid {cells = M.insert cIdx newCell (cells gr)}

    grid = constructCollisionsGrid w h s objs
    (rMin, rMax) = rowRange grid
    (cMin, cMax) = colRange grid
    cellIndices = [(x, y) | x <- [rMin .. (rMax - 1)], y <- [cMin .. (cMax - 1)]]
    solvedGrid = foldr solveCollisionsForCell grid cellIndices

type Cell a = [a]

solveCollisionsBetweenCells :: (RigidObject a) => Cell a -> Cell a -> (Cell a, Cell a)
solveCollisionsBetweenCells x y = splitAt xLength $ solveCollisionsNaively (x ++ y)
  where
    xLength = length x

-- Utilities to work with grid.
data CollisionsGrid a = CollisionsGrid
  { cells :: M.Map Int (Cell a),
    -- width :: Int,
    -- height :: Int,
    -- cellSize :: Int,
    rowRange :: (Int, Int),
    colRange :: (Int, Int)
  }

columns :: (RigidObject a) => CollisionsGrid a -> Int
columns g = cMax - cMin
  where
    (cMin, cMax) = colRange g

constructCollisionsGrid :: (RigidObject a) => (Int, Int) -> (Int, Int) -> Int -> [a] -> CollisionsGrid a
constructCollisionsGrid (wMin, wMax) (hMin, hMax) s objs =
  CollisionsGrid
    { cells = foldr (insert . (\o -> (posToCellIdx o, [o]))) M.empty objs,
      rowRange = (rMin, rMax),
      colRange = (cMin, cMax)
      -- width = w,
      -- height = h,
      -- cellSize = s
    }
  where
    sFloat = fromIntegral s :: Float
    rMin = floor (fromIntegral hMin / sFloat)
    rMax = ceiling (fromIntegral hMax / sFloat)
    cMin = floor (fromIntegral wMin / sFloat)
    cMax = ceiling (fromIntegral wMax / sFloat)

    nbCols = cMax - cMin

    insert = uncurry $ M.insertWith (++)

    posToCellIdx o = r * nbCols + c
      where
        -- FIXME: handle negative values of x and y.
        (V2 x y) = position_ o

        r = floor (x / sFloat)
        c = floor (y / sFloat)

getCell :: (RigidObject a) => Int -> Int -> CollisionsGrid a -> Maybe (Cell a)
getCell r c g = cellIdx r c g >>= (cells g M.!?)

getNeighboringCells :: (RigidObject a) => Int -> Int -> CollisionsGrid a -> [(Int, Int, Cell a)]
getNeighboringCells r c g = foldr gatherNeighbors [] neighboringIndices
  where
    neighboringIndices =
      [ (r - 1, c - 1),
        (r - 1, c),
        (r - 1, c + 1),
        (r, c - 1),
        (r, c + 1),
        (r + 1, c - 1),
        (r + 1, c),
        (r + 1, c + 1)
      ]

    gatherNeighbors (rCell, cCell) acc = case getCell rCell cCell g of
      Just x -> (rCell, cCell, x) : acc
      Nothing -> acc

cellIdx :: (RigidObject a) => Int -> Int -> CollisionsGrid a -> Maybe Int
cellIdx r c g
  | rMin <= r && r < rMax && cMin <= c && c < cMax = Just $ r * nbCols + c
  | otherwise = Nothing
  where
    (rMin, rMax) = rowRange g
    (cMin, cMax) = colRange g
    nbCols = columns g
