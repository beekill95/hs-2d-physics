module Ball where

import qualified Container as C
import qualified Graphics.Gloss as G
import Linear (Metric (distance, signorm), V2 (V2))
import Object
import Renderer
import VerletObject

data Ball = Ball
  { center :: Vec2,
    radius :: Float,
    velocity :: Vec2,
    acceleration :: Vec2,
    color :: G.Color,
    previousCenter :: Maybe Vec2
  }

instance Object Ball where
  position_ = center

instance Movable Ball where
  velocity_ = velocity
  acceleration_ = acceleration

  updatePosition p o = o {center = p}
  updateVelocity v o = o {velocity = v}
  updateAcceleration a o = o {acceleration = a}

instance VerletObject Ball where
  previousPosition_ (Ball {previousCenter = c}) = c
  updatePreviousPosition x b = b {previousCenter = Just x}

instance Renderable Ball where
  render (Ball {center = (V2 x y), radius = r, color = c}) = G.color c $ G.translate x y $ G.circleSolid r

instance RigidObject Ball where
  isCollided x y = d < (radius x + radius y)
    where
      d = distance (center x) (center y)

  -- Naive collision solver.
  solveCollision b1@(Ball {center = c1, radius = r1}) b2@(Ball {center = c2, radius = r2})
    | isCollided b1 b2 =
        ( b1 {center = c1 - unitDir * pure halfIntersection},
          b2 {center = c2 + unitDir * pure halfIntersection}
        )
    | otherwise = (b1, b2)
    where
      d = distance c1 c2
      halfIntersection = (r1 + r2 - d) / 2

      unitDir = signorm (c2 - c1)

instance C.ContainerBouncer Ball where
  bounceOff
    (C.Container {C.radius = rContainer, C.center = cContainer})
    ball@(Ball {radius = r, center = c}) =
      if d < (rContainer - r)
        then -- The ball is still in the container.
          ball
        else -- The ball touches or is outside the boundary of the container.
          ball {center = newPos}
      where
        d = distance cContainer c

        -- Calculate the direction from the ball to center of the container.
        unitDir = signorm (cContainer - c)

        -- Move the ball inside the boundary.
        newPos = c + unitDir * pure (d + r - rContainer)
