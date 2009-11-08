import Text.Parsec hiding (digit)

type Parser = Parsec String ()

mass 'C' = 12
mass 'H' = 1
mass 'O' = 16

digit :: Parser Int
digit = oneOf "23456789" >>= \c -> return $ read [c]

atom = oneOf "CHO"
atoms = do
	a  <- atom
	d  <- (digit <|> return 1)
	as <- (atoms <|> return [])
	return $ replicate d a ++ as

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
	let Right m = parse group "" s in sum $ map mass m
	) =<< getLine
