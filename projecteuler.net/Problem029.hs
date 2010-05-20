module Problem029 where

import Data.List
import Data.Map (toList, fromList)

answer = length $ nub' [ (a^b,0) | a <- [2..100], b <- [2..100] ]
	where nub' = toList . fromList -- faster nub

main = print answer
