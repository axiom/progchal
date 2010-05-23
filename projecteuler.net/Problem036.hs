module Problem036 where

import Numeric
import Data.Char

isDecimalPalindrome x = show x == (reverse . show) x

isBinaryPalindrome x = b == (reverse b)
	where b = decToBin x

decToBin = flip (showIntAtBase 2 intToDigit) ""

answer = sum $ filter (\n -> isBinaryPalindrome n && isDecimalPalindrome n) [1..1000000]

main = print answer
