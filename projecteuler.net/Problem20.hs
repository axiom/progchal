module Problem20 where

import Data.Char

fac n = product [1..n]
answer = sum $ map digitToInt $ show $ fac 100
main = print answer
