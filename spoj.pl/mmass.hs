import Text.Parsec hiding (digit)

type Parser = Parsec String ()
data Atom = C | H | O
data Mole = M [Atom]
class Mass a where mass :: Integral n => a -> n

instance Mass Atom where
	mass C = 12
	mass H = 1
	mass O = 16

instance Mass Mole where
	mass (M as) = (sum . map mass) as

digit :: Parser Int
digit = oneOf "23456789" >>= \c -> return $ read [c]

atom :: Parser Atom
atom = do
	a <- oneOf "CHO"
	case a of
		'C' -> return C
		'H' -> return H
		'O' -> return O

atoms :: Parser [Atom]
atoms = do
	a  <- atom
	d  <- (digit <|> return 1)
	as <- (atoms <|> return [])
	return $ replicate d a ++ as

group :: Parser [Atom]
group =
	do
		char '('
		g  <- group
		char ')'
		d  <- (digit <|> return 1)
		g' <- (group <|> return [])
		return $ concat (replicate d g) ++ g'
	<|> do
		a <- atoms
		g <- (group <|> return [])
		return $ a ++ g

main = putStrLn . show . (\s ->
	let Right m = parse (group >>= \as -> return $ M as) "" s in mass m
	) =<< getLine
