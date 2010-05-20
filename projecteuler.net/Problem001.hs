module Problem001 where

sumupto x = sum $ takeWhile (< x) numbers where
	numbers = filter (\x -> x `mod` 3 == 0 || x `mod` 5 == 0) [1..]

main = print $ sum [3,6..999] + sum [5,15..999] - sum [15,30..999]
