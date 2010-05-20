module Problem025 where

fibs = 1 : 1 : zipWith (+) fibs (tail fibs)
answer = head [ i + 1 | i <- [0..], (fibs !! i) >= 10^1000-1 ]
main = print answer
