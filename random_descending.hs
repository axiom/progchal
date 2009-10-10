{-# LANGUAGE BangPatterns #-}
import Text.Printf (printf)

expected :: Integer -> Double -> String -> Double
expected _  !acc []    = acc
expected !h !acc (c:s) = case c of
	'\n' -> expected h acc s
	' '  -> expected h acc s
	'('  -> expected (h + 1) acc s
	')'  -> expected (h - 1) acc s
	_    -> let (v, r) = (head . reads) (c:s) in
		expected h (acc + v * 0.5^h) r

main :: IO ()
main = getContents >>= printf "%.2f\n" . expected 0 0
