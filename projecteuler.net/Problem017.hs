module Problem017 where

units, tens, hundreds, thousands, letters :: Int -> Int

units x = [0,3,3,5,4,4,3,5,5,4] !! x

tens x = (map units [0..9] ++ [3,6,6,8,8,7,7,9,8,8] ++ regular) !! x
	where regular = [ t + units u | t <- [6,6,5,5,5,7,6,6], u <- [0..9] ]

hundreds x = units h + tn + 7
	where
		h = x `div` 100
		t = x `mod` 100
		tn = tens t

-- thousands x = units t + hundreds h + length "thousand"
thousands x
	-- -- Eleven hundred etc...
	-- | x `mod` 100 == 0 && x `div` 100 < 20
	-- = tens (x `div` 100) + 7

	| otherwise = units (x `div` 1000) + 8 + letters (x `mod` 1000)

letters x
	| x < 10 = units x + connector x
	| x < 100 = tens x + connector x
	| x < 1000 = hundreds x + connector x
	| x < 10000 = thousands x + connector x

connector x
	| x < 10 = 0
	| x < 100 = 0
	| x < 1000 && x `mod` 100 == 0 = 0 
	| x < 10000 && x `mod` 1000 == 0 = 0
	| x < 2000 && x `mod` 100 == 0 = 0
	| otherwise = 3

answer = sum $ map letters [1..1000]

main = print answer
