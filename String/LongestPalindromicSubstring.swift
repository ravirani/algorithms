//
//  LongestPalindromicSubstring.swift
//  
//
//  Solved using Manacher's algorithm
//  https://en.wikipedia.org/wiki/Longest_palindromic_substring
//
//

import Foundation

extension String {
  subscript(index: Int) -> Character {
    return self[self.index(self.startIndex, offsetBy: index)]
  }
}

func longestPalindromicSubstring(inputString: String) -> Int {
  let stringLength = inputString.characters.count
  guard stringLength > 1 else {
    return stringLength
  }
 
  var palindromicStringLengths = Array(repeating: 1, count: stringLength)
  var indexWithMaxLength = 0, maxLength = Int.min
  var length = 1, indexGoingForward = 0, indexGoingBackward = 0
  
  for currentIndex in 1..<stringLength {
  
    let rightEdgeIndex = palindromicStringLengths[indexWithMaxLength]/2 + indexWithMaxLength

    // Current index is entirely self contained in the previous max length palindrome
    if currentIndex < rightEdgeIndex {
      // Set the count to the left side equivalent because thats the min length palindrome that exists 
      // at this index
      palindromicStringLengths[currentIndex] = palindromicStringLengths[indexWithMaxLength - (currentIndex - indexWithMaxLength)]
      
      // If the length of this palindrome ends here, we don't need to evaluate this character
      if currentIndex + palindromicStringLengths[currentIndex]/2 == currentIndex {
        continue
      }
    }
    
    length = 1
    indexGoingBackward = currentIndex - 1
    indexGoingForward = currentIndex + 1
    while indexGoingBackward >= 0 &&
          indexGoingForward < stringLength &&
          inputString[indexGoingBackward] == inputString[indexGoingForward]
    {
      length += 2
      indexGoingBackward -= 1
      indexGoingForward += 1
    }
    
    palindromicStringLengths[currentIndex] = length
    if length > maxLength {
      maxLength = length
      indexWithMaxLength = currentIndex
    }
  }
  
  return maxLength
}

// Base case
assert(longestPalindromicSubstring(inputString: "abadefg") == 3)

// Case checking right boundary condition
assert(longestPalindromicSubstring(inputString: "abaxabaxabb") == 9)

// Case checking guard conditions
assert(longestPalindromicSubstring(inputString: "a") == 1)
assert(longestPalindromicSubstring(inputString: "") == 0)

