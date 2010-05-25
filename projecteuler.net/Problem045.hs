module Problem045 where

import Data.IntSet

-- Arbitrary
limit = 100000

-- Note from internet: all hexagonal numbers are also triangle numbers.
triangle, pentagonal, hexagonal :: IntSet
triangle   = fromList [ n * (  n+1) `div` 2 | n <- [0..limit] ]
pentagonal = fromList [ n * (3*n-1) `div` 2 | n <- [0..limit] ]
hexagonal  = fromList [ n * (2*n-1)         | n <- [0..limit] ]

tph = triangle `intersection` pentagonal `intersection` hexagonal
answer = head . dropWhile (<=40755) $ toList tph

main = print answer
