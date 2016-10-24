//
//  IceCreamParlor.swift
//
//  Given an amount and ice cream costs (ice cream flavor i has cost c[i])
//  find two flavors such that totalAmount is spent.
//  https://www.hackerrank.com/challenges/ctci-ice-cream-parlor
//

import Foundation

// Time complexity = O(n)
// A more efficient approach could be to sort the original data and
// then perform binary search if the data set is pretty large.
func getFlavors(totalAmount: Int, iceCreamCosts: [Int]) -> (Int, Int) {
  
  // Dictionary to represent amount left from total and previously chosen flavor
  var remainingAmountToSpend = [Int: Int]()
  for (flavorIndex, flavorCost) in iceCreamCosts.enumerated() {
    
    if flavorCost >= totalAmount {
      continue
    }
    
    if remainingAmountToSpend[flavorCost] == nil {
      remainingAmountToSpend[totalAmount - flavorCost] = flavorIndex
    } else {
      return (remainingAmountToSpend[flavorCost]!, flavorIndex)
    }
  }
  
  // If control gets here, check if anything is of amount that is
  // half the total amount to see if we can order two of the same
  // flavors
  if let flavorIndex = remainingAmountToSpend[totalAmount/2] {
    return (flavorIndex, flavorIndex)
  }
  
  return (-1, -1)
}

// Base case
assert(getFlavors(totalAmount: 4, iceCreamCosts: [1, 2, 3, 4]) == (0, 2))

// Case where we can order two flavors with the same amount
assert(getFlavors(totalAmount: 8, iceCreamCosts: [1, 2, 3, 4]) == (3, 3))

// No combination works
assert(getFlavors(totalAmount: 9, iceCreamCosts: [1, 2, 3, 4]) == (-1, -1))
