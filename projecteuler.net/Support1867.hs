module Support1867 (answer) where

import Data.Array
import Data.List
import Text.Printf

table t = tbl
	where
		n = length t
		tbl = listArray ((0,0), (n, n)) [ f r c | r <- [0..n], c <- [0..n] ]
		f r c
			| r == 0 || c == 0 || c == n || c > r = 0
			| otherwise = t !! (r - 1) !! (c - 1)
				+ maximum [tbl ! (r - 1, c - 1), tbl ! (r - 1, c)]


turn (a,b) = (b,a)
answer t = fst . maximum $ map turn $ assocs $ table t
