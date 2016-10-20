//
//  CoinChangeWays.swift
//
//
// Problem: Given a total amount and coins, find the total number of ways to get
// to the total amount. Each coin can be used as many times as needed.
// Hackerrank Link - https://www.hackerrank.com/challenges/coin-change
//
// E.g., Total = 13, Coins = 2, 6, 7, 3
// Ways = 6
// {6, 2, 2, 3}, {7, 3, 3}, {2, 2, 2, 2, 2, 3}, {6, 3, 2, 2}, {3, 3, 3, 2, 2}, {7, 6}
//
// Solve sub-problems of total ways to reach every value up to total given every coin
//
// E.g., matrix for above example
//
//      0 1 2 3 4 5 6 7 8 9 10 11 12 13
//  2   0 0 1 0 1 0 1 0 1 0  1  0  1  0
//  6   0 0 1 0 1 0 2 0 2 0  2  0  3  0
//  7   0 0 1 0 1 0 2 1 2 1  2  1  3  2
//  3   0 0 1 1 1 1 3 2 3 4  4  4  7  6
//

import Foundation

func waysToGetTotalAmount(_ total: Int, coinDenominations: [Int]) -> Int {
  guard total > 0 && coinDenominations.count > 0 else {
    return 0
  }
  
  // Build up how many ways can we form every value up to total (Bottoms up)
  var waysByValue = Array(repeating: [Int](), count: coinDenominations.count)
  
  for (coinIndex, coinValue) in coinDenominations.enumerated() {
    
    waysByValue[coinIndex].append(0)
    for value in 1...total {
      if value - coinValue == 0 {
        // If the coinValue matches the value, there is atleast one way
        // to get to the value
        waysByValue[coinIndex][value-coinValue] = 1
      }
      
      if value >= coinValue {
        if coinIndex > 0 {
          // Total ways would be total ways to get to amount from this coin
          // plus total ways to get the amount from the previously seen coins
          waysByValue[coinIndex].append(waysByValue[coinIndex - 1][value] + waysByValue[coinIndex][value-coinValue])
        } else {
          // Consider just this coin if this is the first coin
          waysByValue[coinIndex].append(waysByValue[coinIndex][value-coinValue])
        }
      } else {
        if coinIndex > 0 {
          // If total amount is less than its value, total ways will be
          // total ways to get to amount from previous coins
          waysByValue[coinIndex].append(waysByValue[coinIndex - 1][value])
        } else {
          // If this is only coin and total amount is less than its value
          // there is no way to get to total
          waysByValue[coinIndex].append(0)
        }
      }
    }
  }
  
  return waysByValue[coinDenominations.count - 1][total]
}

// Base case
assert(waysToGetTotalAmount(13, coinDenominations: [2, 6, 7, 3]))

// Case where total is less than all provided coins
assert(waysToGetTotalAmount(1, coinDenominations: [2, 6, 7, 3]) == 0)
