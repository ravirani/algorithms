//
//  BinaryTreeTraversals.swift
//  
//  Recursive preorder, inorder, and postorder traversals (DFS)
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

// V L R
func preorderTraversal(_ rootNode: Node?) -> [Int] {
  guard let node = rootNode else {
    return []
  }
  
  var output = [Int]()
  output += [node.data]
  
  if let left = node.left {
    output += preorderTraversal(left)
  }
  
  if let right = node.right {
    output += preorderTraversal(right)
  }
  
  return output
}

// L V R
func inorderTraversal(_ rootNode: Node?) -> [Int] {
  guard let node = rootNode else {
    return []
  }
  
  var output = [Int]()
  
  if let left = node.left {
    output += inorderTraversal(left)
  }
  
  output += [node.data]
  
  if let right = node.right {
    output += inorderTraversal(right)
  }
  
  return output
}

// L R V
func postorderTraversal(_ rootNode: Node?) -> [Int] {
  guard let node = rootNode else {
    return []
  }
  
  var output = [Int]()
  
  if let left = node.left {
    output += postorderTraversal(left)
  }
  
  if let right = node.right {
    output += postorderTraversal(right)
  }
  
  output += [node.data]
  
  return output
}

