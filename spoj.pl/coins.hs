import qualified Data.Map as M

exchange c = (c `div` 2, c `div` 3, c `div` 4)
base = M.fromAscList $ zip [0..11] [0..11]

-- Share a memoization between many input values.
optlist xs = optlist' base xs
optlist' _ [] = []
optlist' m xs = let (o, m') = opt m (head xs) in o : optlist' m' (tail xs)

-- Memoization by using map. (Sparse entries, list would not be helpful.)
opt m n | n < 12 = (n,m)
opt m n = case M.lookup n m of
	Just o  -> (o,m)
	Nothing ->
		let (a,b,c) = exchange n in
		let (x,m') = opt m a in
		let (y,m'') = opt m' b in
		let (z,m''') = opt m'' c in
		let o = max n $ x + y + z in
		opt (M.insert n o m''') n

main = getContents >>= (sequence_ . map print . optlist . map read . lines)
