module Problem010 where

import Data.Numbers.Primes

ans = sum $ takeWhile (< 2000000) primes
main = print ans
