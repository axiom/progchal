import Data.Array
import Data.List

table height = tbl
	where
		tbl = listArray ((0,0), (width, height)) [0..]
		width = height
