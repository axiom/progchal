module Problem028 where

answer' x = sum $ 1 : [ cof g + 2*g*i | g <- [1..n], i <- [1..4] ]
	where n = x `div` 2 -- Number of layers outside of the center.

cof n = 1 + 8 * (sum [0..pred n])

-- In n by n spiral outer corners are:
--     n^2
--     n^2 - 1*(n+1)
--     n^2 - 2*(n+1)
--     n^2 - 3*(n+1)
--
-- Which yields the formula: 4n^2 - 6n + 6, so just sum each set of corners
-- down to the 3 by 3 spiral and then add 1.
answer x = 1 + sum [ 4*n*n - 6*n + 6 | n <- [3,5..x] ]
main = print . answer $ 1001
