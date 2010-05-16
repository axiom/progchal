import Debug.Trace
import qualified Data.Map as Map
import Control.Monad.State.Lazy as State

step :: Integer -> Integer
step n
	| even n = n `div` 2
	| otherwise = 3*n + 1

chain :: Integer -> [Integer]
chain 1 = [1]
chain n = (:) n $ chain $ step n

chainlength :: Integer -> Integer
chainlength 1 = 1
chainlength n = (+) 1 $ chainlength $ step n
