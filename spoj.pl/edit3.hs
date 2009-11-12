module Main where

import System.IO
import Control.Monad.State.Strict
import Data.Maybe
import Data.Char
import Text.Parsec hiding (State)

-- Data types {{{1

data Edit
	= Move Int
	| Insert Int String
	| Delete Int
	| Get Int
	| Prev
	| Next
	| Nop
	deriving (Eq, Show, Read)

-- Hello #World!
-- |     |+----- after
-- |     +------ cursor
-- +------------ before (stored in reverse)
data ES = ES
	{ cursor :: Int
	, before :: String
	, after  :: String
	}
	deriving (Eq, Show)

type Editor a = State ES a

emptyES = ES 0 [] []

text = enumFromTo (chr 32) (chr 126)

-- Parsing {{{1

type Parser = Parsec String ()

pEdit = many1 $
	choice [pNext, pPrev, pMove, pGet, pDelete, pInsert, pNothing]

pNothing :: Parser Edit
pNothing = do
	number
	return Nop

pMove, pDelete, pNext, pPrev, pInsert, pGet :: Parser Edit
pMove   = pNCon "Move" Move
pDelete = pNCon "Delete" Delete
pGet    = pNCon "Get" Get

pNext = pCon "Next" Next
pPrev = pCon "Prev" Prev

pInsert = do
	string "Insert"
	spaces
	n <- number
	spaces
	s <- count n $ oneOf text
	return $ Insert n s

pCon :: String -> Edit -> Parser Edit
pCon s c = do
	string s
	return c

pNCon :: String -> (Int -> Edit) -> Parser Edit
pNCon s c = do
	string s
	spaces
	n <- number
	return $ c n

number :: Parser Int
number = do
	ds <- digits
	return $ foldl combine 0 ds
	where
		digits = do
			ds <- many1 digit
			notFollowedBy digit
			return $ map (\d -> ord d - ord '0') ds
		combine x y = 10*x + y

-- Evaluation {{{1
eval :: Edit -> Editor (Maybe String)

eval (Move k) = do
	cur <- gets cursor
	let diff = k - cur
	if diff < 0
		then replicateM_ (-diff) (eval Prev)
		else replicateM_ diff (eval Next)
	return Nothing

eval (Insert k str) = do
	modify $ \s -> s { after = take k str ++ after s }
	return Nothing

eval (Delete k) = do
	modify $ \s -> s { after = drop k $ after s }
	return Nothing

eval (Get k) = do
	a <- gets after
	return $ Just $ take k a

eval Prev = do
	es <- get
	let b = tail $ before es
	let a = (head . before) es : after es
	let k' = cursor es - 1
	when (k' >= 0) $ put $ ES k' b a
	return Nothing

eval Next = do
	es <- get
	let b = (head . after) es : before es
	let a = tail $ after es
	let k' = cursor es + 1
	put $ ES k' b a
	return Nothing

eval Nop = return Nothing

-- Utility {{{1

-- editShit :: [Edit] -> Editor [String]
-- editShit [] = return []
editShit as = do
	l <- mapM eval as
	return $ catMaybes l

fromEdit as = evalState (editShit as) emptyES

-- Main {{{1
main :: IO Int
main = do
	cases <- read `fmap` getLine
	input <- getContents

	replicateM_ cases $ do
		let split = head . words $ input
		let Right whops = parse pEdit "" $ filter (flip elem text) input
		let w = fromEdit whops
		mapM putStrLn w
	return cases
