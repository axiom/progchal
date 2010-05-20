module Problem12 where

numbers = scanl1 (+) [1..]
sr = ceiling . sqrt . fromInteger

divisors :: Integer -> Int
divisors n = sum [ 2 | c <- [1..sr n], n `mod` c == 0 ] - 1

answer = head $ filter ((>500) . divisors) numbers
main = print answer
