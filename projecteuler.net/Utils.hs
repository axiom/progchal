module Utils where

-- Get the i:th digit of n (from left).
(#@) :: Integral n => n -> n -> n
n #@ i = n `mod` 10^(k+1) `div` 10^k
	where
		k = d - i - 1
		d = floor $ log (fromIntegral n) / log 10 + 1

-- Give it really low prio because it's most likely to be used to extract a
-- final answer, i.e. top of the tree-thingy.
infixr 5 #@
