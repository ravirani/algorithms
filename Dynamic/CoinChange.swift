//
//  CoinChange.swift
//
//
// Problem: Given a total amount and coins, find the min. coins to get
// to the total amount.
//
// Solved using dynamic programming where we solve the sub-problem of reaching
// every value up to the total with min. coins.
//

import Foundation

func minCoinsForTotal(_ total: Int, coins: [Int]) -> Int {
  
  guard total > 0 && coins.count > 0 else {
    return 0
  }
  
  // Set max a little lower than actual max to avoid overflows
  let max = Int.max-100
  var minCoinsForValue = Array(repeating: max, count: total + 1)
  var finalCoins = Array(repeating: -1, count: total + 1)
  
  // For value zero, we don't need any coins
  minCoinsForValue[0] = 0
  
  for (index, coin) in coins.enumerated() {
    if coin > total {
      // If coin is lower than total, no way to get to total
      // using just this coin
      continue
    }
    
    // start with value greater than the current coin denomination
    for value in coin..<minCoinsForValue.count {
      
      // if this value can be achieved in min. number of current coin
      // then record this fact, else wait for a better denomination
      let minCoins = 1 + minCoinsForValue[value - coin]
      if minCoins < minCoinsForValue[value] {
        minCoinsForValue[value] = minCoins
        finalCoins[value] = index
      }
    }
  }
  
  // Print coins used
  var finalCoinCount = minCoinsForValue[total]
  var valueIndex = total
  var finalCoinDenominations = [Int]()
  
  while finalCoinCount > 0 && finalCoinCount != max {
    finalCoinDenominations.append(coins[finalCoins[valueIndex]])
    valueIndex -= coins[finalCoins[valueIndex]]
    finalCoinCount -= 1
  }
  print(finalCoinDenominations)
  
  return minCoinsForValue[total] == max ? 0 : minCoinsForValue[total]
}

// Case where total is less than all denominations
assert(minCoinsForTotal(1, coins: [7, 2, 3, 6]) == 0)

// Case total is zero
assert(minCoinsForTotal(0, coins: [7, 2, 3, 6]) == 0)

// Case coins is empty
assert(minCoinsForTotal(1, coins: []) == 0)

// Basic case
assert(minCoinsForTotal(12, coins: [7, 2, 3, 6]) == 2)
