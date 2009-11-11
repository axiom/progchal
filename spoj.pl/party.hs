import Control.Monad
import Data.Maybe
import Data.List

p1, p2 :: [(Int, Int)]
p1 =
	[ (12, 3)
	, (15, 8)
	, (16, 9)
	, (16, 6)
	, (10, 2)
	, (21, 9)
	, (18, 4)
	, (12, 4)
	, (17, 8)
	, (18, 9)
	]

p2 =
	[ (10, 2)
	, (11, 7)
	, (12, 8)
	, (12, 9)
	, (13, 5)
	, (13, 8)
	, (15, 5)
	, (16, 2)
	, (16, 8)
	, (19, 10)
	]

optimal p' m = let
	opt' m i
		| i == 0 || m == 0 = 0
		| pc i > m = opt' m (i - 1)
		| otherwise = max (opt' m $ i - 1) (pf i + (opt' (m - (pc i)) (i - 1)))
	in let res = [ opt' m i | m <- [0 .. m], i <- [0 .. pl] ] in
		(fromJust $ fmap (flip div (succ pl)) $ findIndex (== (last res)) res, last res)

	where
		p = sort p'
		pl = (pred . length) p
		pf i = snd $ p !! i
		pc i = fst $ p !! i
		lt i = fromJust $ find (< i) $ findIndices (< (pc i)) $ map fst p

main = do
	str <- getLine
	let (m:c:_) = map read $ words str
	if (m == 0 && c == 0) then return () else do
		parties <- replicateM c $ do
			str <- getLine
			let (c:f:_) = map read $ words str
			return (c,f)
		let (c, f) = optimal (parties :: [(Int, Int)]) m
		putStrLn $ show c ++ " " ++ show f
		empty <- getLine
		main
