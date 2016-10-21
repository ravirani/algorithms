//
//  QuickSort.swift
//  
//  Pick a pivot (there are variety of ways with pros/cons and some might be
//  suitable over others if the incoming data is constrained or behavior is known
//  but we take the last element as pivot below for simplicity)
//  and move all lower values to left and higher values to right. Then recursively
//  do the above for left sub-array minus the pivot and right sub-array minus the pivot.
//
//

import Foundation

func quickSort(_ inputArray: inout [Int], lowerIndex: Int, upperIndex: Int) {
  guard lowerIndex < upperIndex && lowerIndex >= 0 else {
    return
  }
  
  let pivot = inputArray[upperIndex]
  var newIndexForPivot = 0
  
  for index in 0..<upperIndex {
    if inputArray[index] < pivot {
      if newIndexForPivot != index {
        swap(&inputArray[newIndexForPivot], &inputArray[index])
      }
      
      newIndexForPivot += 1
    }
  }
  
  if upperIndex != newIndexForPivot {
    swap(&inputArray[upperIndex], &inputArray[newIndexForPivot])
  }
  
  quickSort(&inputArray, lowerIndex: lowerIndex, upperIndex: newIndexForPivot - 1)
  quickSort(&inputArray, lowerIndex: newIndexForPivot + 1, upperIndex: upperIndex)
}

// Base case
var arr = [4, 8, 1, 10, 9, 38, 48]
quickSort(&arr, lowerIndex: 0, upperIndex: arr.count - 1)
assert(arr == [1, 4, 8, 9, 10, 38, 48])

// Case where array consists of only two elements
var arr1 = [14, 8]
quickSort(&arr1, lowerIndex: 0, upperIndex: arr1.count - 1)
assert(arr1 == [8, 14])
