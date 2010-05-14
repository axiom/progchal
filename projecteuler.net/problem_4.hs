-- Palindromes are divisable by 11
answer = maximum [ x * y | x <- [110,121..999], y <- [100..999], show (x * y) == (reverse . show) (x * y)]

-- Find big palindromes which have two factors in [100,999].
-- Do this by first finding the first factor, and then check if the other
-- factor is in the range.
smartanswer = head [m
	| b <- [0..9]
	, c <- [0..9]
	, m <- [900009 + 10010 * b + 1100 * c]
	, [ x | x <- [100..990], m `mod` x == 0, m `div` x < 1000] /= []]

main = putStrLn $ show smartanswer
