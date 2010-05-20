module Problem007 where

import qualified Data.Map as M
-- import Data.List.Ordered

-- prims = sieve [2..]
-- sieve (p:xs) = (:) p $ sieve $ xs `minus` map (*p) (p : xs)

-- primes = 2 : [ x | x <- [3..], isPrime x ]
-- isPrime x = all (\p -> x `mod` p > 0) $ takeWhile (\p -> p * p <= x) primes
-- isPrime x = all ((> 0) . mod x) $ takeWhile ((<= x) . (^2)) primes

sieve xs = sieve' xs M.empty
	where
		sieve' [] table = []
		sieve' (x:xs) table = case M.lookup x table of
			Nothing -> x : sieve' xs (M.insert (x*x) [x] table)
			Just facts -> sieve' xs (foldl reinsert (M.delete x table) facts)
				where
					reinsert table prime = M.insertWith (++) (x+prime) [prime] table

prims = sieve [2..]

ans = (!!) prims . pred

main = putStrLn $ show $ ans 10001
