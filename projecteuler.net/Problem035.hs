module Problem035 where

import Data.Numbers.Primes
import qualified Data.IntSet as IS
import Utils

smallprimes = takeWhile (<= 1000000) primes

-- IntSet for fast lookup of
isCircularPrime = all ((`IS.member` primeset) . fromIntegral . numberify) . rotations . digits
	where primeset = IS.fromList $ map fromIntegral smallprimes

main = print . length . filter isCircularPrime $ smallprimes
