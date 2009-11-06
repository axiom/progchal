generate :: (Num n, Enum n) => [(n, n)]
generate = concat [ zip (sublist s) (reverse (sublist s)) | s <- [1 ..] ]

sublist :: (Num n, Enum n) => Int -> [n]
sublist size
	| size `mod` 2 /= 0 = reverse $ take size [1 ..]
	| otherwise = take size [1 ..]

main :: IO ()
main = do
	cases <- getLine
	go . read $ cases
	where
		go :: Int -> IO ()
		go 0 = return ()
		go i = do
			n <- getLine
			let ((p,q):_) = take 1 $ (drop . pred . read) n $ generate
			putStr $ "TERM " ++ n ++ " IS "
			putStrLn $ show p ++ "/" ++ show q
			go . pred $ i
