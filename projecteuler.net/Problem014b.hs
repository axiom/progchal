module Problem014b where

import Data.Array
import Data.List

table n = a where
	a = listArray (1,n) $ 1 : [ 1 + step x | x <- [2..n] ]
	step x
		| x' <= n = a ! x'
		| otherwise = 1 + step x'
		where x' = if even x then x `div` 2 else 3*x + 1

maxad = (foldl1' $ \a b -> if snd a > snd b then a else b) . assocs . table
main = putStrLn $ show $ maxad 1000000
