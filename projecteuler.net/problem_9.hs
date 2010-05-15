ans = [ product [a,b,c]
	| a <- [1..limit]
	, b <- [a..limit]
	, c <- [sqrt $ a * a + b * b]
	, b < c
	, a + b + c == 1000
	, a * a + b * b == c * c ]
	where limit = 1000
