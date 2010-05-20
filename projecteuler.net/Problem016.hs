module Problem016 where

import Data.Char

ans = sum $ map digitToInt $ show $ 2^1000
main = print ans
