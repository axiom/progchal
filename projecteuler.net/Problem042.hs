module Problem042 where

import Data.Char
import Utils

isTnum n = any (== n) $ scanl1 (+) [1..100]

wval = sum . map (\c -> ord c - ord 'A' + 1)
w = map wval . words . rep '"' ' ' . rep ',' ' '

main = do
	input <- readFile "words.txt"
	print . length . filter isTnum . w $ input
