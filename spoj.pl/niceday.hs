{-# LANGUAGE BangPatterns #-}

import Control.Monad

type Rank = (Integer, Integer, Integer)


-- Quicksort by third competition.
qsort [] = []
qsort !(x@(_,_,p):xs) =
	qsort [ y | y@(_,_,z) <- xs, z <= p ]
	++ [x] ++
	qsort [ y | y@(_,_,z) <- xs, z > p ]


-- Check if a point is contained within a coastline (made up of a number of
-- points).
contained [] _ = False
contained !(c:cl) !p@(xp,yp,_)
	| within c = True
	| otherwise = contained cl p
	where
		within (x,y,_)
			| xp > x && yp > y = True
			| otherwise = False

traverse :: [Rank] -> [Rank] -> [Rank]
traverse !coastline [] = coastline
traverse !coastline !(p:ps)
	| contained coastline p = traverse coastline ps
	| otherwise = traverse (p:coastline) ps

excellent :: [(Integer, Integer, Integer)] -> Integer
excellent !points = fromIntegral $ length $ traverse [] (qsort points)

main = do
	cases <- read `fmap` getLine
	replicateM_ cases $ do
		contestants <- read `fmap` getLine
		points <- replicateM contestants $ do
			[x,y,z] <- (map read . words) `fmap` getLine
			return $ (x,y,z)
		print $ excellent points
