ans n =
	let a = sum [1..n] ^ 2 in
	let b = sum . map (^2) $ [1..n] in
	a - b

main = putStrLn $ show $ ans 100
