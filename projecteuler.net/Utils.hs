module Utils where

import Data.Map (toList, fromList)

-- Apply a function to something s.t. we generate numbers which we then sum.
f #+ xs = sum $ map f xs
infixr 5 #+


-- Get the i:th digit of n (from left).
(#@) :: Integral n => n -> n -> n
n #@ i = n `mod` 10^(k+1) `div` 10^k
	where
		k = d - i - 1
		d = floor $ log (fromIntegral n) / log 10 + 1

-- Give it really low prio because it's most likely to be used to extract a
-- final answer, i.e. top of the tree-thingy.
infixr 5 #@


-- Proper divisors of n
divisors n = (:) 1 $ inub $ ds ++ [ n `div` d | d <- ds]
	where ds = [ d | d <- [2..(ceiling . sqrt . fromIntegral) n] , n `mod` d == 0 ]


-- Get sorted list of unique numbers in list.
inub :: Integral n => [n] -> [n]
inub = map fst . toList . fromList . map (flip (,) 0)
