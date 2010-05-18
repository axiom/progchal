import Data.Numbers.Primes

ans = sum $ takeWhile (< 2000000) primes
