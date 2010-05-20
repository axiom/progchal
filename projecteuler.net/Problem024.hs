module Problem024 ((#%)) where

import Data.List

-- Find lexographical permutation #n
xs #% n = project (sort xs) $ map fst $ run n m
	where m = pred $ head [ i | i <- [0..], fac i > n ]

fac n = product [1..n]

-- Get the elements in the permutation order from the original list.
project x [] = x
project xs (i:is) = let x = xs !! i in x : (flip project is $ delete x xs)

-- Get a in x * a <= n
cof n x
	| n < x || x == 0 = (0, n)
	| otherwise = let c = head [ i - 1 | i <- [1..], n < x * i ] in (c, n - c * x)

run n x
	| 0 == n || n < z = []
	| otherwise = let (c, rest) = cof n z in (c, z) : run rest (x - 1)
	where z = fac x

-- Print permutation as number.
main = print . foldl1 (\d -> ((d * 10) +)) $ [0..9] #% 999999
