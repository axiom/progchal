main = getLine >>= turn . read
	where
		turn :: Int -> IO ()
		turn 0 = return ()
		turn i = do
			input <- getLine
			putStrLn []
			let (low : (high : _)) = words input
			sequence_ . map print $ primes (read low) (read high)
			turn . pred $ i


primes :: Int -> Int -> [Int]
primes low high = dropWhile (< low) $ sieve [2 .. high]
	where
		sieve (x:xs) = x : sieve [ d | d <- xs, d `mod` x > 0 ]
		sieve x = x
