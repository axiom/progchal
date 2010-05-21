module Problem030 where

import Data.Char

-- Would be nice to have some sort of motivation as to why we go to six digits
-- but not futher.
--
-- Update: biggest number for one digit: 9^5 = 59049, so biggest number for x
-- digits is x*59049, for x = 7 we have 413343, but that is only six digits,
-- thus we don't have to check for numbers beyond six digits.
numbers =
	[ n [a,b,c,d,e,f]
	| a <- [0..9], b <- [0..9], c <- [0..9]
	, d <- [0..9], e <- [0..9], f <- [0..9]
	, n [a,b,c,d,e,f] > 1
	, n [a,b,c,d,e,f] == a^5 + b^5 + c^5 + d^5 + e^5 + f^5
	]
	where n = foldl1 ((+) . (*10))

-- Shorter but slower solution, guessing because of the string stuff.
numbers' =
	[ x | x <- [2..(6*(9^5))]
	, x == (sum . map ((^5) . digitToInt) . show) x
	]

answer = sum numbers
main = print answer
