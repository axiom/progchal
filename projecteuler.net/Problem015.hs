module Problem015 where

import Data.Array

paths n = tbl
	where
		tbl = listArray ((0,0), (n,n)) [ f row col | row <- [0..n], col <- [0..n] ]
		f _ 0 = 1
		f 0 _ = 1
		f r c = tbl ! (pred r, c) + tbl ! (r, pred c)

answer = snd . last . assocs . paths

-- Binomial expansion/coefficient/pascals triangle.
closed n = fac (2*n) `div` (fac n)^2
	where fac n = product [1..n]

main = print . closed $ 20
