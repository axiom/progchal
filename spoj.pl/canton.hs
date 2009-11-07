import Data.List (findIndex)
import Control.Monad (replicateM_)

before n
	| n < 2 = 0
	| otherwise = flip div 2 $ (n - 1) * (n - 2)

size n = let Just x = findIndex (n <) $ map whop [1 ..] in succ x

whop n = flip div 2 (n * (n + 1)) + 1

term n
	| s `mod` 2 > 0 = (i, s - i)
	| otherwise = (s - i, i)
	where
		i = n - before s
		s = succ . size $ n

main = getLine >>= \i -> replicateM_ (read i) $ do
	n <- getLine
	let (p,q) = term . read $ n
	putStrLn $ "TERM " ++ n ++ " IS "++show p ++ "/" ++ show q
