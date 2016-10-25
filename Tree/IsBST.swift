//
//  IsBST.swift
//  
//
//  Recursively go through every node making sure the BST
//  property is true at each node
//  Complexity: O(n)
//

import Foundation

class TreeNode {
  let data: Int
  var leftNode: TreeNode?
  var rightNode: TreeNode?
  
  init(_ nodeData: Int) {
    data = nodeData
  }
}

func isBST(rootNode: TreeNode?, min: Int, max: Int) -> Bool {
  guard let node = rootNode else {
    return true
  }
  
  return node.data > min &&
    node.data < max &&
    isBST(rootNode: node.leftNode, min: min, max: node.data) &&
    isBST(rootNode: node.rightNode, min: node.data, max: max)
}


// Case a BST
/*
            100
      40          110
    20  60      105   120
 
 */
let rootNode = TreeNode(100)
rootNode.leftNode = TreeNode(40)
rootNode.rightNode = TreeNode(110)

rootNode.leftNode!.leftNode = TreeNode(20)
rootNode.leftNode!.rightNode = TreeNode(60)

rootNode.rightNode!.leftNode = TreeNode(105)
rootNode.rightNode!.rightNode = TreeNode(120)

assert(isBST(rootNode: rootNode, min: Int.min, max: Int.max) == true)


// Case not a BST
/*
                30
          20           40
      10     25     35   120
    5   20
 
 */
let rootNode1 = TreeNode(30)
rootNode1.leftNode = TreeNode(20)
rootNode1.rightNode = TreeNode(40)

rootNode1.leftNode!.leftNode = TreeNode(10)
rootNode1.leftNode!.rightNode = TreeNode(25)

rootNode1.leftNode!.leftNode!.leftNode = TreeNode(5)
rootNode1.leftNode!.leftNode!.rightNode = TreeNode(20)

rootNode1.rightNode!.leftNode = TreeNode(105)
rootNode1.rightNode!.rightNode = TreeNode(120)

assert(isBST(rootNode: rootNode1, min: Int.min, max: Int.max) == false)
