module Problem014 where

import Data.List (foldl1')

step :: Integer -> Integer
step n
	| even n = n `div` 2
	| otherwise = 3*n + 1

len :: Integer -> Integer
len n = len' n 0 where
	len' 1 c = succ c
	len' n c = len' (step n) (succ c)

chain = takeWhile (/= 1) . iterate step
maxad = foldl1' max $ map (\i -> (len i, i)) [1..1000000]

-- Run with large stack size
main = putStrLn $ show maxad
