module Problem21 where

import Data.List

sr = ceiling . sqrt . fromIntegral
d 0 = 0
d 1 = 1
d n = sum . init . nub . sort $ p ++ [ n `div` d | d <- p ]
	where p = [ d | d <- [1..sr n - 1], n `mod` d == 0 ]

answer = sum [ a | a <- [1..10000], a == (d . d) a, d a /= a ]
main = print answer
