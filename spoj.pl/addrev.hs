main = do
	n <- getLine
	turn . read $ n
	where
		turn 0 = return ()
		turn i = do
			inpt <- getLine
			let (n1:(n2:_)) = words inpt
			let s = (read . reverse) n1 + (read . reverse) n2
			let s' = (reverse . show) s
			let s'' = (show . (+0) . read) s'
			putStrLn s''
			turn . pred $ i
