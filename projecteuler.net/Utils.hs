module Utils where

import Data.Map (toList, fromList)
import Data.Char (digitToInt)

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


-- Convert a number into its digits.
digits :: Integral n => n -> [n]
-- digits = map (fromIntegral . digitToInt) . show
-- digits n = [ n `div` 10^(i-1) `mod` 10^i | i <- [1..3] ]
digits = fst . head . filter ((==) 0 . snd) . tail
	. iterate (\(d, n) -> let (q, r) = n `divMod` 10 in (r:d, q)) . (,) [] . abs


-- Convert list of digits to the number they represent in base ten.
numberify :: Integral n => [n] -> n
numberify = foldl1 ((+) . (*10))


-- Get sorted list of unique numbers in list.
inub :: Integral n => [n] -> [n]
inub = map fst . toList . fromList . map (flip (,) 0)


-- Arithmetic sum (?) sum [1..n]
arisum n = n*(1 + n) `div` 2


-- Replace list members.
rep s r (a:as) = (if s == a then r else a) : rep s r as
rep _ _ _ = []


-- Search in sorted list.
insorted _ [] = False
insorted z (x:xs)
	| z == x = True
	| z < x = False
	| otherwise = insorted z xs


-- Get all rotations of a list, e.g. [1,2,3] -> [[1,2,3],[2,3,1],[3,1,2]]
rotations xs = rot xs []
	where
		rot [] _ = []
		rot r@(x:xs) ys = (r ++ ys) : rot xs (ys ++ [x])


{-
solen (x:xs) (y:ys)
	| x > y = solen (x:xs) ys
	| x < y = 0
	| otherwise = 1 + solen xs ys
solen _ _ = 0

-- Gives the length of the common inits of two lists.
initlen :: Eq a => [a] -> [a] -> Int
initlen xs ys = length . takeWhile id $ zipWith (==) xs ys
-}
