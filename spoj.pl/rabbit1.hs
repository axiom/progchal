{-# LANGUAGE BangPatterns #-}
import Control.Monad

cultivate a y 0 = a + y
cultivate a y m = cultivate (a + y) a (m - 1)
notBoxed rs b = rs `mod` (2 ^ b)

calc m b = notBoxed (cultivate 1 0 (m - 1)) b

calc' m b = sexyTime 1 0 (m - 1)
	where
		bs = 2^b
		sexyTime !a !y 0 = (a + y) `mod` bs
		sexyTime !a !y m = sexyTime ((a + y) `mod` bs) a (m - 1)

main = do
	cases <- getLine
	replicateM_ (read cases) $ do
		[m, b] <- (map read . words) `fmap` getLine
		print $ calc m b
