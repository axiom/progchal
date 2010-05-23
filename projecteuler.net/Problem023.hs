module Problem023 where

import Utils

abundant = [ n | n <- [1..28123], (sum . divisors) n > n ]
sumoftwo = [ a + b | a <- abundant, b <- abundant ]

-- answer = [ n | n <- [1..28123], False == elem n sumoftwo ]
-- answer = sum [ n | n <- [1..28123], False == canbe n ]
answer = sum $ filter ((== False) . canbe) [1..28123]

canbe n = 0 < length
	[ () | y <- [0..n-1]
	, y == (head . dropWhile (<y)) abundant
	, (n - y) == (head . dropWhile (<(n - y))) abundant
	]

main = print answer
