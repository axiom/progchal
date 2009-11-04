fac 1 = 1
fac n = n * fac (n - 1)

main = (go . read) =<< getLine
	where
		go 0 = return ()
		go n = do
			i <- getLine
			print $ (fac . read) i
			go (n - 1)
