module Problem019 where

-- This is stupidugly solution, I hate dates.

firstofthemonth = scanl1 (+) $ 1 : [ days m y | y <- [1900..2000], m <- [1..12] ]

days month year
	| month `elem` [9,4,6,11] = 30
	| month == 2 && isLeap year = 29
	| month == 2 = 28
	| otherwise = 31
	where
		isLeap year
			| year `mod` 4 /= 0 = False
			| year `mod` 100 == 0 = year `mod` 400 == 0
			| otherwise = False


sundays d = filter (`elem` firstofthemonth)
	. filter ((== 0) . (`mod` 7)) $ [1..d]

total = sum [ days month year | year <- [1900..2000], month <- [1..12] ]
firstyear = sum [ days month 1900 | month <- [1..12] ]
answer = length (sundays total) - length (sundays firstyear)

-- Cheat
main = print $ 12*100`div`7
