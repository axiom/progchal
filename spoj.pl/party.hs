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

subsetsum p w = optimal'' p (pred $ length p) w

cost p w = sum $ cost' (pred $ length p) w
	where
		pc i = fst $ p !! i
		pf i = snd $ p !! i
		cost' i v
			| i < 0 || v < 0 || pc i > v = []
			| otherwise = if pf i + optimal''' p (i - 1) (v - pc i) > optimal''' p (i - 1) v
				then pc i : cost' (i - 1) (v - pc i)
				else cost' (i - 1) v

optimal''' p' i w
	| i < 0 || w < 0 = 0
	| otherwise = optimal'' p' i w

optimal'' p'
	= let opt i
		= let opt' v
			| i < 0 = 0
			| pc i > v = optimal''' p' (i - 1) v
			| otherwise = max (optimal''' p (i - 1) v) (pf i + optimal''' p (i - 1) (v - pc i))
		in (map opt' [0 ..] !!)
	in (map opt [0 ..] !!)
	-- in [ [ opt i v | v <- [0 .. w] ] | i <- [0 .. pred $ length p] ] -- !! n !! w
	where
		p = sort p'
		pc i = fst $ p !! i
		pf i = snd $ p !! i

optimal' p m = let res = map (optimal p m) [0 .. pl] in res
	-- (fromJust $ fmap (flip div (succ pl)) $ findIndex (== (last res)) res, last res)
	where pl = (pred . length) p

optimal p' = let
	opt m = let
		opt' i
			| i == 0 || m == 0 = 0
			| pc i > m = opt m (i - 1)
			| otherwise = max (opt m $ i - 1) (pf i + (opt (m - (pc i)) (i - 1)))
		in (map opt' [0 ..] !!)
	in (map opt [0 ..] !!)

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
		let f = subsetsum (parties :: [(Int, Int)]) m
		let c = cost parties m
		putStrLn $ show c ++ " " ++ show f
		empty <- getLine
		main
