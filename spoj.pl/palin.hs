isPalin :: (Enum a, Eq a) => [a] -> Bool
isPalin str = str == reverse str

nextPalin :: (Enum a, Show a) => a -> a
nextPalin n = head [ p | p <- [succ n ..], isPalin . show $ p ]

main = do
	i <- getLine
	turn . read $ i
	where
		turn 0 = return ()
		turn i = do
			m <- getLine
			let next = nextPalin . read $ m :: Int
			print next
			turn . pred $ i
