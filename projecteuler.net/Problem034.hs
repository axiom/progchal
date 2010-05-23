module Problem034 where

import Data.Char

-- Quite arbitrary upper limit here, but it works.
answer = sum [ n | n <- [3..fac 9]
	, (==) n $ sum . map (fac . digitToInt) $ show n ]

fac n = product [1..n]

main = print answer
