module Problem048 where

answer n = sum [ x^x | x <- [1..n] ] `mod` 10^10
main = print . answer $ 1000
