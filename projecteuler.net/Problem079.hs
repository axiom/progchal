module Problem079 where

import qualified Data.Map as M
import Data.List
import Data.Char
import Utils

-- Find out what digits can follow a specific digit.
[] #># pin = pin
(z:x:xs) #># pin = case M.lookup z pin of
	Nothing -> M.insert x xs $ xs #># pin
	Just ys -> M.insert x (inub (x:ys)) $ xs #># pin
infixr 2 #>#
