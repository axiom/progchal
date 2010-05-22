module Problem097 where

number = 28433 * 2^7830457 + 1
answer = number `mod` 10^10
main = print answer
