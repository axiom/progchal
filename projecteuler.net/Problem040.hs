module Problem040 where

import Utils
import Data.Char

-- "Brute force" solution.
simple = product $ map (digitToInt . (ls !!) . (pred)) [1,10,100,1000,10000,100000]
	where ls = concatMap show [1..]

-- Number of numbers with fewer digits than [1,2,..].
numbers = map (\n -> (n*9*10^n - 10^n + 1) `div` 9) [1..]

newindex n = (n - last ls, 10^(length ls))
	where ls = takeWhile (<n) numbers

digitat i
	| i < 10 = i
	| otherwise = base + number #@ offset
	where
		(index, base) = newindex i
		(number, offset) = (index - 1) `divMod` (length . show $ base)

answer = product $ map digitat [1,10,100,1000,10000,100000]
main = print answer
