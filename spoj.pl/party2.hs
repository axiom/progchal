import Control.Monad.State
import Control.Applicative
import System.Exit
import qualified Data.Map as M
import Data.List (sort)

-- Data types {{{1

type Mupp a = State M a

type Party = (Int, Int)

type Table = M.Map (Int, Int) Int

data M = M
	{ parties :: [Party]
	, table   :: Table
	}
	deriving (Show)

-- Data inits. {{{1

emptyM = M
	{ table   = M.empty
	, parties = []
	}

p1, p2 :: [Party]
p1 =
	[ (12, 3)
	, (15, 8)
	, (16, 9)
	, (16, 6)
	, (10, 2)
	, (21, 9)
	, (18, 4)
	, (12, 4)
	, (17, 8)
	, (18, 9)
	]

p2 =
	[ (50, 10)
	, (13, 8)
	, (19, 10)
	, (16, 8)
	, (12, 9)
	, (10, 2)
	, (12, 8)
	, (13, 5)
	, (15, 5)
	, (11, 7)
	, (16, 2)
	]

pmax = take 100 $ concat $ repeat $ p1 ++ p2
wmax :: Int
wmax = 500

-- Computations {{{1

party :: Int -> Mupp Party
party i = (!! i) <$> gets parties


optimal :: Int -> Int -> Mupp Int
optimal i v
	| i < 0 || v < 0 = return 0
	| otherwise = do
		t <- gets table
		case M.lookup (i, v) t of
			Just x  -> return x
			Nothing -> optimal' t
	where
		optimal' t = {-# SCC "optimal'" #-} do
			(co, fo) <- party i
			c1 <- optimal (i - 1) v
			m  <- if co > v then return c1
				else do
					c2 <- optimal (i - 1) (v - co)
					return $ max c1 (fo + c2)

			modify $ \s -> s { table = M.insert (i, v) m t }
			return m


precalc pl m = precalc' 0 0 pl m where
	precalc' i v n m
		| v > m = precalc' (i + 1) 0 n m
		| i > n = return ()
		| otherwise = optimal i v >> precalc' i (v + 1) n m


backtrack i v
	| i < 0 = return 0
	| otherwise = do
		(co, fo) <- party i
		c1 <- optimal (i - 1) v
		c2 <- optimal (i - 1) (v - co)
		if co > v || c1 > (fo + c2)
			then backtrack (i - 1) v
			else backtrack (i - 1) (v - co) >>= \c' -> return $ co + c'


doit :: [Party] -> Int -> (Int, Int)
doit p m = flip evalState emptyM { parties = sort p } $ do
	precalc pl m
	f <- optimal pl m
	c <- backtrack pl m
	return (c, f)
	where pl = pred $ length p


main = do
	(m:c:_) <- (map read) . words <$> getLine
	when (m == 0 && c == 0) exitSuccess 

	parties <- replicateM c $ do
		(c:f:_) <- (map read) . words <$> getLine
		return (c,f)

	let (c, f) = doit parties m
	putStrLn $ show c ++ " " ++ show f
	getLine >> main
