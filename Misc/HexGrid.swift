//
//  HexGrid.swift
//

import Foundation

/*
 
  ___       ___       ___
 /   \     /   \     /   \
/  0  \___/  6  \___/ 12  \
\     /   \     /   \     /
 \___/  3  \___/  9  \___/
 /   \     /   \     /   \
/  1  \___/  7  \___/ 13  \
\     /   \     /   \     /
 \___/  4  \___/ 10  \___/
 /   \     /   \     /   \
/  2  \___/  8  \___/ 14  \
\     /   \     /   \     /
 \___/  5  \___/ 11  \___/
     \     /   \     /
      \___/     \___/
 
 
 Problem: Assume the above example structure
 given two numbers height and width.
 
 Print all neighboring tiles for any given tile.
 
 Neighbors should be printed as follows in the clockwise order:
 
      N
  NW     NE
 
  SW     SE
      S
 
 E.g., for 7, the neighbors will be 6, 9, 10, 8, 4, 3
 
 For cases where the neighbor does not exist, print -1
 
 */


class HexGrid {
  
  let MISSING_VALUE = -1
  let gridRows: Int
  let gridColumns: Int
  
  init(rows: Int, columns: Int) {
    gridRows = rows
    gridColumns = columns
  }
  
  func getValue(row: Int, column: Int) -> Int {
    guard row >= 0 && column >= 0 && row < gridRows && column < gridColumns else {
      return MISSING_VALUE
    }
    
    return row + gridRows * column
  }
  
  func getNorthValue(row: Int, column: Int) -> Int {
    return getValue(row: row - 1, column: column)
  }
  
  func getSouthValue(row: Int, column: Int) -> Int {
    return getValue(row: row + 1, column: column)
  }
  
  func getNorthEastValue(row: Int, column: Int) -> Int {
    // Even
    if column % 2 != 0 {
      return getValue(row: row, column: column + 1)
    }
    
    return getValue(row: row - 1, column: column + 1)
  }
  
  func getSouthEastValue(row: Int, column: Int) -> Int {
    // Even
    if column % 2 != 0 {
      return getValue(row: row + 1, column: column + 1)
    }
    
    return getValue(row: row, column: column + 1)
  }
  
  func getNorthWestValue(row: Int, column: Int) -> Int {
    // Even
    if column % 2 != 0 {
      return getValue(row: row, column: column - 1)
    }
    
    return getValue(row: row - 1, column: column - 1)
  }
  
  func getSouthWestValue(row: Int, column: Int) -> Int {
    // Even
    if column % 2 != 0 {
      return getValue(row: row + 1, column: column - 1)
    }
    
    return getValue(row: row, column: column - 1)
  }
  
  func getTileNeighbors(elementIndex: Int) -> [Int] {
    let (row, column) = (elementIndex % gridRows, elementIndex / gridRows)
    var output = [Int]()
    let neighborValues = [
      getNorthValue(row: row, column: column),
      getNorthEastValue(row: row, column: column),
      getSouthEastValue(row: row, column: column),
      getSouthValue(row: row, column: column),
      getSouthWestValue(row: row, column: column),
      getNorthWestValue(row: row, column: column)
    ]
    
    for value in neighborValues {
      if value >= 0 && value < (gridRows * gridColumns) {
        output.append(value)
      } else {
        output.append(MISSING_VALUE)
      }
    }
    
    return output
  }
}

// Case center (even) with all neighbors present
assert(HexGrid(rows: 3, columns: 6).getTileNeighbors(elementIndex: 4) == [3, 7, 8, 5, 2, 1])

// Case center (odd) with all neighbors present
assert(HexGrid(rows: 3, columns: 6).getTileNeighbors(elementIndex: 7) == [6, 9, 10, 8, 4, 3])

// Top left
assert(HexGrid(rows: 3, columns: 6).getTileNeighbors(elementIndex: 0) == [-1, -1, 3, 1, -1, -1])

// Top right
assert(HexGrid(rows: 3, columns: 6).getTileNeighbors(elementIndex: 15) == [-1, -1, -1, 16, 13, 12])

// Bottom left
assert(HexGrid(rows: 3, columns: 6).getTileNeighbors(elementIndex: 2) == [1, 4, 5, -1, -1, -1])

// Bottom right
assert(HexGrid(rows: 3, columns: 6).getTileNeighbors(elementIndex: 17) == [16, -1, -1, -1, -1, 14])
