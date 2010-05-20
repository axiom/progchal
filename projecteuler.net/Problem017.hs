module Problem017 where

-- inwords :: Integer -> String
inwords n
	| n < 10    = [units n]
	| n < 20    = [tens n, []]
	| n < 100   = tens n      : (inwords $ n `mod` 10)
	| n < 1000  = hundres n   : (inwords $ n `mod` 100)
	| n < 10000 = thousands n : (inwords (n `mod` 1000))

thousands 0 = []
thousands x = units (x `div` 1000) ++ " thousand"

hundres 0 = []
hundres x = units (x `div` 100) ++ " hundred"

tens 0 = []
tens x
	| x > 19 = case t of
		2 -> "twenty"
		3 -> "thirty"
		4 -> "fourty"
		5 -> "fivty"
		6 -> "sixty"
		7 -> "seventy"
		8 -> "eighty"
		9 -> "ninety"
	| x < 20 = case u of
		0 -> "ten"
		1 -> "eleven"
		2 -> "twelve"
		n  -> units n ++ "teen"
	where
		u = x `mod` 10
		t = x `div` 10

units 0 = []
units x = words "one two three four five six seven eight nine" !! (pred x)
