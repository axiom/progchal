import System.IO
import Control.Monad
main = do
	n <- getLine
	print $ bishops $ read n
	eof <- isEOF
	when (not eof) main

bishops n
	| n < 2 = n
	| otherwise = 2*n - 2
