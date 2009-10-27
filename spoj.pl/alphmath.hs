import Data.Maybe (fromJust)
import Data.List (findIndex)
import System.IO (isEOF)

alphaToNum :: String -> Integer
alphaToNum str@(s:ss)
	| s == '-' = negate $ alphaToNum ss
	| otherwise = read . concatMap show $ map charToDigit str
	where
		charToDigit :: Char -> Integer
		charToDigit c = fromIntegral . fromJust $ findIndex (== c) a
		a = "ABCDEFGHIJ"

numToAlpha :: Integer -> String
numToAlpha num
	| num < 0 = '-' : (numToAlpha . negate) num
	| otherwise = map (a !!) $ map (read . (:[])) $ show num
	where a = "ABCDEFGHIJ"

parse :: String -> Integer
parse str = let (l : (op : (r : _))) = words str in operator op (alphaToNum l) (alphaToNum r)
	where
		operator op = case op of
			"+" -> (+)
			"-" -> (-)
			"*" -> (*)
			"/" -> div

main = do
	input <- getLine
	putStrLn $ numToAlpha . parse $ input
	eof <- isEOF
	if eof then return () else main
