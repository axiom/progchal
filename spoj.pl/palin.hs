import Data.List (nub)


-- | Check if something is a palindrome.
isPalin :: Eq a => [a] -> Bool
isPalin str = str == reverse str


-- | Find the next palindrome larger than the base case.
nextPalin :: String -> String
nextPalin digits = upsize (reverse outer) center
	where
		len = length digits
		clen = len `div` 2

		outer
			| even len = take (pred clen) digits
			| otherwise = take clen digits

		center
			| even len = replicate 2 (digits !! (pred clen))
			| otherwise = [digits !! clen]
		

upsize outer center
	-- Expand center because of overflowing 9.
	| head center == '9' && length outer > 0
		= upsize (tail outer) (head outer : center)

	-- Only zeros in center so we set center center to ones.
	| nub center == "0"
		= reverse outer ++ replicate chlen '0' ++ replicate (clen - 2 * chlen) '1' ++ replicate chlen '0' ++ outer

	-- Just find the next palindrome of the center and add the outer padding.
	| otherwise
		= reverse outer ++ (show . next . read) (mirror center) ++ outer

	where
		-- | Naivly calculate next palindrome of a number.
		next :: Integer -> Integer
		next n = head [ x | x <- [(succ n) ..], (isPalin . show) x ]

		clen = length center
		chlen = if even clen
			then clen `div` 2 - 1
			else clen `div` 2


mirror l
	| (even . length) l = l ++ reverse l
	| otherwise = l ++ (tail . reverse) l


main = do
	inpt <- getContents
	let (_:ls) = lines inpt
	turn ls
	where
		turn [] = return ()
		turn (l:ls) = do
			putStrLn $ nextPalin l
			turn ls
