-- From http://en.literateprograms.org/Pi_with_Machin's_formula_(Haskell)
arccot x unity = arccot' x unity 0 start 1 1
	where start = unity `div` x

arccot' x unity sum xpower n sign
	| term == 0 = sum
	| otherwise = arccot' x unity (sum + sign*term) (xpower `div` (x*x)) (n+2) (-sign)
	where term = xpower `div` n

machin_pi digits = pi' `div` poop
	where
		poop = 10^10
		unity = poop * 10^digits
		pi' = 16*(arccot 5 unity) - 4*(arccot 239 unity)

paj k = '3' : '.' : (tail . show) (machin_pi k)

main = putStrLn $ paj 72000
