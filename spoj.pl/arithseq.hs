numbers a d n = [ a + i * d | i <- [0 .. n] ]

main = do
	args <- getContents
	let (a : d : n : x : _) = words . head . lines $ args
	print $ length . filter (((==) . head) x) . concatMap show $ numbers (read a) (read d) (read n)
