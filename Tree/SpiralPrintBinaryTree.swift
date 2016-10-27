//
//  SpiralPrintBinaryTree.swift
//
//  Spiral print a binarry tree.
//
//  Use two stacks to keep track of two consecutive levels of a tree
//  and each inputting elements in the different order than
//  the previous level. For e.g., starting with the root, the next
//  level would be Left to Right and one thereafter would be Right to Left
//  and so on.
//
//

import Foundation

class Node {
  
  var data: Int
  var left: Node?
  var right: Node?
  
  init(_ nodeData: Int) {
    self.data = nodeData
  }
}

func spiralPrintBinaryTree(_ rootNode: Node) -> [Int] {
  var stack1 = Array<Node>()
  var stack2 = Array<Node>()
  var node: Node
  
  // Keep looping over elements until either of the stack has an element
  // Keep flipping which stack to use going from one level to another
  
  var output = [Int]()
  stack1.append(rootNode)
  while stack1.count > 0 || stack2.count > 0 {
    
    while (stack1.count > 0) {
      node = stack1.removeLast()
      output.append(node.data)
      
      if let left = node.left {
        stack2.append(left)
      }
      
      if let right = node.right {
        stack2.append(right)
      }
    }
    
    while (stack2.count > 0) {
      node = stack2.removeLast()
      output.append(node.data)
      
      if let right = node.right {
        stack1.append(right)
      }
      
      if let left = node.left {
        stack1.append(left)
      }
    }
  }
  
  return output
}
