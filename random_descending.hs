import Text.Printf

expected :: String -> Integer -> Double -> Double
expected [] _ acc = acc
expected (c:s) h acc = case c of
	'(' -> expected s (h + 1) acc
	')' -> expected s (h - 1) acc
	_   -> let (v, r) = (head . reads) (c:s) in expected r h $ acc + v * 0.5^h

main = getLine >>= \l -> let v = expected l 0 0 in printf "%.2f\n" v
