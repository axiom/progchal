{-# LANGUAGE BangPatterns #-}

import Control.Monad

type Mat = ((Integer, Integer), (Integer, Integer))

rabbits = ((1,1),(1,0))
identity = ((1,0),(0,1))

ans b m = (snd . fst $ gen (m + 1)) `mod` bs
	where
		bs = 2 ^ b
		gen n = mexp rabbits n
		mul :: Mat -> Mat -> Mat
		mul ((a,b),(c,d)) ((aa,bb),(cc,dd)) = ((x11,x12),(x21,x22))
			where
				x11 = (a*aa + b*cc) `mod` bs
				x12 = (a*bb + b*dd) `mod` bs
				x21 = (c*aa + d*cc) `mod` bs
				x22 = (c*bb + d*dd) `mod` bs

		mexp :: Mat -> Integer -> Mat
		mexp m n
			| n == 0 = identity
			| n == 1 = m
			| even n = mexp (mul m m) (n `div` 2)
			| odd n  = mul m (mexp (mul m m) ((n - 1) `div` 2))


main = do
	cases <- read `fmap` getLine
	replicateM_ cases $ do
		[m, b] <- (Prelude.map read . words) `fmap` getLine
		print $ ans b m
