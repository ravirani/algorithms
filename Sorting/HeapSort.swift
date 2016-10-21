//
//  HeapSort.swift
//  
//  Recursively keep forming a max heap, which puts the highest value
//  at index 0. After each iteration move the root of the heap (index 0)
//  to the last position (relative because we are moving in-place) in the array.
//
//

import Foundation

func buildMaxHeap(_ inputArray: inout [Int], lastIndex: Int) -> [Int] {
  // Starting from the potential lowest level, check if the heap property is intact at each
  // sub-tree parent otherwise make adjustments.
  // For each subtree at index i,
  //  its parent is at index floor((i - 1)/2),
  //  its left child is at 2i + 1 and
  //  its right child is at 2i + 2
  
  var leftIndex = 0
  var rightIndex = 0
  var parentIndex = 0
  var indexToBeSwapped = -1
  
  for index in (0..<(lastIndex + 1) / 2).reversed() {
    parentIndex = index
    
    while true {
      leftIndex = 2*parentIndex + 1
      rightIndex = 2*parentIndex + 2
      indexToBeSwapped = parentIndex
      
      if leftIndex <= lastIndex && inputArray[leftIndex] > inputArray[indexToBeSwapped] {
        indexToBeSwapped = leftIndex
      }
      
      if rightIndex <= lastIndex && inputArray[rightIndex] > inputArray[indexToBeSwapped] {
        indexToBeSwapped = rightIndex
      }
      
      // Stop when we have reached the parent
      if parentIndex == indexToBeSwapped {
        break
      }
      
      swap(&inputArray[parentIndex], &inputArray[indexToBeSwapped])
      // Keep evaluating the subtree
      parentIndex = indexToBeSwapped
      
    }
  }
  
  return inputArray
}

func heapSort(_ inputArray: inout [Int], lastIndex: Int) {
  guard lastIndex > 0 && inputArray.count > 1 else {
    return
  }
  buildMaxHeap(&inputArray, lastIndex: lastIndex)
  swap(&inputArray[0], &inputArray[lastIndex])
  heapSort(&inputArray, lastIndex: lastIndex - 1)
}

// Base case
var arr = [4, 8, 1, 10, 9, 38, 48]
heapSort(&arr, lastIndex: arr.count - 1)
assert(arr == [1, 4, 8, 9, 10, 38, 48])

// Case where array consists of only two elements
var arr1 = [14, 8]
heapSort(&arr1, lastIndex: arr1.count - 1)
assert(arr1 == [8, 14])
