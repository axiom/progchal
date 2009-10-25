-- | Check if something is a palindrome.
isPalin :: Eq a => [a] -> Bool
isPalin str = str == reverse str


-- | Find the next palindrome larger than the base case.
nextPalin :: Integer -> Integer
nextPalin base = read $ upsize outer center
	where
		digits = show base
		len = length digits

		outer
			| even len = take (pred (len `div` 2)) digits
			| otherwise = take (len `div` 2) digits

		center
			| even len = replicate 2 (digits !! (pred (len `div` 2)))
			| otherwise = [digits !! (len `div` 2)]
		
		-- | Check if valid num.
		okay :: Integer -> Bool
		okay num = num > base && (isPalin . show) num


upsize outer center
	| length outer > 0 && head center == '9' = upsize (init outer) (last outer : center ++ [last outer])
	| otherwise = outer ++ (show . next . read) center ++ reverse outer
	where
		-- | Naivly calculate next palindrome of a number.
		next :: Integer -> Integer
		next n = head [ x | x <- [(succ n) ..], (isPalin . show) x ]


main = do
	i <- getLine
	turn . read $ i
	where
		turn 0 = return ()
		turn i = do
			m <- getLine
			let next = nextPalin . read $ m
			putStrLn . show $ next
			turn . pred $ i
