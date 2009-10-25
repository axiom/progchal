data Expr
	= Var Char
	| Plus  Expr  Expr 
	| Minus Expr  Expr 
	| Mul   Expr  Expr 
	| Div   Expr  Expr 
	| Pow   Expr  Expr 

instance Show Expr where
	show = showExpr


showExpr :: Expr -> String
showExpr (Var a) = [a]
showExpr op = case op of
	Plus   l r -> showExpr l ++ showExpr r ++ "+"
	Minus  l r -> showExpr l ++ showExpr r ++ "-"
	Mul    l r -> showExpr l ++ showExpr r ++ "*"
	Div    l r -> showExpr l ++ showExpr r ++ "/"
	Pow    l r -> showExpr l ++ showExpr r ++ "^"


readsExpr :: ReadS Expr
readsExpr ('(':s) = [(Plus l r, u) | (l, '+' : t) <- readsExpr s , (r, ')' : u) <- readsExpr t ]
readsExpr (c:xs) = [(Var c, xs)]


main = return ()
