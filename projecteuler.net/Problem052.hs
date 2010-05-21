module Problem052 where

import Data.List

answer = head [ x | x <- [1..], and . map ((== d x 2) . (d x)) $ [3..6] ]
	where d x = sort . show . (*x)

main = print answer
