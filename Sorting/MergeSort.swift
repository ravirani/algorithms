//
//  MergeSort.swift
//  
//  Recursively split the passed in array until there is only one value left.
//  Sort and merge at each step rebuilding the array.
//

import Foundation

func combine(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
  var sortedArray = [Int]()
  var leftIndex = 0, rightIndex = 0
  
  while leftIndex < arr1.count || rightIndex < arr2.count {
    if leftIndex < arr1.count && rightIndex < arr2.count {
      if arr1[leftIndex] < arr2[rightIndex] {
        sortedArray.append(arr1[leftIndex])
        leftIndex += 1
      } else {
        sortedArray.append(arr2[rightIndex])
        rightIndex += 1
      }
    } else if leftIndex < arr1.count {
      sortedArray.append(arr1[leftIndex])
      leftIndex += 1
    } else if rightIndex < arr2.count {
      sortedArray.append(arr2[rightIndex])
      rightIndex += 1
    }
  }
  
  return sortedArray
}

func mergeSort(_ inputArray: [Int]) -> [Int] {
  guard inputArray.count > 1 else {
    return inputArray
  }
  
  let middleIndex: Int = Int(inputArray.count / 2)
  let leftHalf = mergeSort(Array(inputArray[0..<middleIndex]))
  let rightHalf = mergeSort(Array(inputArray[middleIndex..<inputArray.count]))
  return combine(leftHalf, rightHalf)
}

assert(mergeSort([2, 10, 3, 200, 110]) == [2, 3, 10, 110, 200])
assert(mergeSort([10, -1, 3, 9, 2, 27, 8, 26]) == [-1, 2, 3, 8, 9, 10, 26, 27])
