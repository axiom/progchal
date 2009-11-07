import Data.Char
import System.IO
import Control.Monad

bad word = head word == '_' || (isUpper . head) word || bad' word
	where
		bad' ('_':[]) = True
		bad' ('_':'_':_) = True
		bad' ('_':c:_) | isUpper c = True
		bad' (x:xs) = bad' xs
		bad' [] = False

isJava word = any isUpper word && not (any (=='_') word)
isCpp word = not (any isUpper word)

toJava enod [] = reverse enod
toJava enod (c:cs)
	| c == '_'  = let u = (toUpper . head) cs in toJava (u:enod) $ tail cs
	| otherwise = toJava (c:enod) cs

toCpp enod [] = reverse enod
toCpp enod (c:cs)
	| isUpper c = toCpp (toLower c:'_':enod) cs
	| otherwise = toCpp (c:enod) cs

trans word
	| word == ""  = ""
	| bad word    = "Error!"
	| isJava word = toCpp [] word
	| isCpp word  = toJava [] word
	| otherwise   = "Error!"

main = do
	word <- getLine
	putStrLn $ trans word
	eof <- isEOF
	when (not eof) main
