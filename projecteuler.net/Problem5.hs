brute = head [ x | x <- [1.. product [1..20]], all (\z -> x `mod` z == 0) [1..20]]

prims = sieve [2..]
sieve (p:xs) = p : sieve [ y | y <- xs, y `mod` p /= 0 ]
primlist = take 20 prims

primefactors x
	| b == x = [x]
	| otherwise = b : primefactors (x `div` b)
	where b = biggest x

biggest x
	| s == x = x
	| otherwise = biggest $ x `div` s
	where s = smallest x

smallest x = case dropWhile (\p -> x `mod` p /= 0) primlist of
	[] -> x
	(s:_) -> s

factors = map primefactors [2..20]
a = [ maximum $ map (fromIntegral . length . filter (== a)) factors | a <- primlist ]

ans = product $ zipWith (^) primlist a

main = putStrLn $ show ans
