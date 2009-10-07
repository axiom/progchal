import Text.Printf
import Data.Traversable

data Tree a = Leaf a | Branch (Tree a) (Tree a)

showsTree :: (Show a) => Tree a -> ShowS
showsTree (Leaf x) = shows x
showsTree (Branch l r) = ('(':) . showsTree l . (' ':) . showsTree r . (')':)

readsTree :: (Read a) => ReadS (Tree a)
readsTree ('(':s) = [(Branch l r, u) | (l, ' ':t) <- readsTree s, (r, ')':u) <- readsTree t ]
readsTree s = [(Leaf x, t) | (x, t) <- reads s ]

instance Show a => Show (Tree a) where
	showsPrec _ x = showsTree x

instance Read a => Read (Tree a) where
	readsPrec _ s = readsTree s

evaluate :: Tree Double -> Double
evaluate (Leaf x) = x
evaluate (Branch l r) = lsum + rsum / 2.00
	where
		lsum = evaluate l
		rsum = evaluate r

main = do
	tmp <- getLine
	let tree = read tmp
	putStrLn $ printf "%.2f" (evaluate tree)
