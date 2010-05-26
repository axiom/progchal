module Problem079 where

-- Code mostly from internetz, but had the same idea yesterday. Just didn't
-- know it was "topological sort". Neat.

import Data.Graph (topSort, buildG)
import Data.List
import Data.Char
import Utils

-- Build edges out of partial key codes.
edges = concatMap (\[x,y,z] -> [(x,y),(y,z)])

-- Figure out which digits are involved in the key code.
useddigits = inub . map digitToInt . filter (`elem` "0123456789")

main = do
	input <- readFile "keylog.txt"
	print . flip intersect (useddigits input) . topSort . buildG (0,9) . edges . parse $ input
	where
		parse = map (digits . read) . words
