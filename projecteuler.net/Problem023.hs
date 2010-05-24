module Problem023 where

-- I did not manage to solve this one. Below is copy-paste. (And still not
-- correct.) I get 4112737, but it should be 4179871.

import Data.Array
import Utils

n = 28124
abundant n = (sum . divisors) n > n
abunds_array = listArray (1,n) $ map abundant [1..n]
abunds = filter (abunds_array !) [1..n]
 
rests x = map (x-) $ takeWhile (<= x `div` 2) abunds
isSum = any (abunds_array !) . rests
 
main = print . sum . filter (not . isSum) $ [1..n]
