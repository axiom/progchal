main = do
	number <- getLine
	if read number /= 42
		then putStrLn number >> main
		else return ()
