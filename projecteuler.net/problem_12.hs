numbers = 1 : zipWith (+) numbers [2..]

primes = 2 : 3 : sieve 0 (tail primes) 5
sieve k (p:ps) x = [ n | n <- [x, x+2..p*p-2], all ((>0) . (x `rem`)) fs ]
	++ sieve (k+1) ps (p*p+2)
	where fs = take k (tail primes)

faclength = length . factorise

factorise x = factorise' x primelist
	where
		primelist = take 10000 primes
		factorise' x [] = [x]
		factorise' x (p:ps)
			| p > x = [x]
			| x == p = [p]
			| x `mod` p == 0 = p : factorise' (x `div` p) ps
			| otherwise = factorise' x ps
