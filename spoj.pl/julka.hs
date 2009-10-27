dostuff apples more
	| otherwise = (lhalf + more `div` 2, shalf - more `div` 2)
	where
		shalf = apples `div` 2
		lhalf = apples - shalf

main = go 10
	where
		go 0 = return ()
		go i = do
			apples <- getLine
			diff <- getLine
			let (klaudia, natalia) = dostuff (read apples) (read diff)
			print $ klaudia
			print $ natalia
			go . pred $ i
