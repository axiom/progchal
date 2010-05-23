module Problem003 where

prims = sieve [2..]
sieve (p:xs) = p : sieve [ x | x <- xs, x `mod` p /= 0 ]

-- Remember primes upto the requested number.
primlist = takeWhile (< 600851475143) prims

primefactors x
	| b == x = [x]
	| otherwise = b : primefactors (x `div` b)
	where b = biggest x

biggest x = if s == x
	then x
	else biggest $ x `div` s
		where s = smallest x

smallest x = case dropWhile (\p -> x `mod` p /= 0) primlist of
	[] -> x
	(s:_) -> s

pf = primefactors
main = print "Dunno?"
