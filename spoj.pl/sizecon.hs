main = do
	q <- getContents
	let c:l = map (max 0 . read) $ lines q
	print $ sum $ take c $ l
