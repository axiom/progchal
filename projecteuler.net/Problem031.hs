module Problem031 where

-- My stupid solution
twopound = sum
	[ 1
	| p50 <- [0..4],  p20 <- [0..10]
	, p10 <- [0..20],  p5 <- [0..40]
	, p2  <- [0..100], l1 <- [0,1,2]
	, l2 <- [0,1]
	, p20*20 + p50*50 + p10*10 + p5*5 + p2*2 + l1*100 + l2*200 <= 200
	]

-- Smart solution from forum.
count :: [Integer] -> Integer -> Integer
count _ 0      = 1
count [c] _    = 1
count (c:cs) s = sum $ map (count cs . (s-)) [0,c..s]

main = print $ count [200,100,50,20,10,5,2,1] 200
