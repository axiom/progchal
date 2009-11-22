{-# LANGUAGE BangPatterns #-}

import Control.Monad
import Data.Maybe
import Data.Map
import Prelude hiding (lookup)

type Gen = (Integer, Integer)
type Month = Integer
type Size = Integer
type DB = Map Gen Month

genpat :: Size -> DB -> Month -> Month -> Gen -> (Month, DB)
genpat _  !db m i !g | m < i = (m, db)
genpat bs !db m i !g@(a,y) = case lookup g db of
	Just _ -> (i, db)
	Nothing ->
		let g' = nextgen bs (a,y) in
		let db' = insert g i db
		in genpat bs db' m (i + 1) g'

nextgen bs (0,0) = (0,0)
nextgen bs !(a,y) =
	let a' = a `mod` bs in
	let y' = y `mod` bs in
	if (a' + y' < bs)
		then (a' + y', a')
		else (y' - bs + a', a')

gen 0 bs !ack = ack
gen n bs !ack = gen (n - 1) bs $! nextgen bs ack

glurp b m = fromJust $ lookup ((m - 1) `mod` period) db'
	where
		bs = 2 ^ b
		(!period, !db) = genpat bs empty m 0 (1,0)
		!db' = fromList $ Prelude.map (\((a, y), m) -> (m, (a + y) `mod` bs)) $ toList db

main = do
	cases <- read `fmap` getLine
	replicateM_ cases $ do
		[m, b] <- (Prelude.map read . words) `fmap` getLine
		print $ glurp b m
