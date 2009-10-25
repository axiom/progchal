import Text.Parsec
import Text.Parsec.String

expr, subexpr, terminal :: Parser String
expr = subexpr <|> terminal

subexpr = do
	open
	left  <- expr
	oper  <- operator
	right <- expr
	close
	return $ left ++ right ++ [oper]

terminal = letter >>= return . (:[])

operator, open, close :: Parser Char
operator = oneOf "+-*/^"
open     = char '('
close    = char ')'


main :: IO ()
main = turn . read =<< getLine
	where
		turn :: Int -> IO ()
		turn 0 = return ()
		turn i = do
			e <- getLine
			let Right s = parse expr "" e in putStrLn s
			turn . pred $ i
