import Data.List
import Data.Char
import Data.Maybe

charscore c = ord c - ord 'A' + 1
wordscore = sum . map charscore
listscore = zipWith (*) [1..]
-- score = listscore . map wordscore

score = zipWith (*) [1..] $ map (sum . map (\c -> ord c - ord 'A' + 1))

-- Get each word in a list
parse = sort . words . (rep '"' ' ') . rep ',' ' '

rep s r (a:as) = (if s == a then r else a) : rep s r as
rep _ _ _ = []

main = readFile "names.txt" >>= print . sum . score . parse
