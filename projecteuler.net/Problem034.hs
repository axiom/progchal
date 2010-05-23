module Problem034 where

import Data.Char
import Utils

-- Upper limit set at 7*fac 9 because seven nines is more than seven times 9!
answer = sum [ n | n <- [3..7*fac 9] , n == (fac . digitToInt) #+ show n ]

-- factorials up to 9
fac = (!!) [1,1,2,6,24,120,720,5040,40320,362880]

main = print answer
