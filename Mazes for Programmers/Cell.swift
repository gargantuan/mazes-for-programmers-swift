//
//  Cell.swift
//  Mazes for Programmers
//
//  Created by Thomas Elders on 13/03/2016.
//  Copyright © 2016 Thomas Elders. All rights reserved.
//

import Foundation

class Cell {

    let row: Int
    let column: Int
    var links = Set<Cell>()
    
    var north:Cell?
    var south:Cell?
    var east:Cell?
    var west:Cell?
    
    init (row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    func linkCell ( cell:Cell, bidirectional: Bool = true ) {
    
        self.links.insert( cell )
        if( bidirectional ) {
            cell.linkCell(self, bidirectional: false)
        }
        
    }
    
    func unlinkCell ( cell:Cell, bidirectional: Bool = true ) {
        self.links.remove( cell )
    }
    
    func isLinkedToCell( cell: Cell? ) -> Bool {
        
        if let unwrappedCell = cell {
            return self.links.contains( unwrappedCell )
        }
        
        return false
    }
    
}

// ------------------------------------------------------------------------------------
// MARK: Hashable
// In order to store a cell in a Set, it needs to conform to the hashable protocol
// ------------------------------------------------------------------------------------
extension Cell: Hashable {
    var hashValue: Int {
        return self.pair()
    }
    
    func pair() -> Int {
        // Matthew Szudzik's Paring Function
        // Generates  unique integer from the row and column index of the cell
        // This function is derived from the answer to [this SO question](http://stackoverflow.com/a/13871379)
        return (column >= row) ? (column * column + column + row) : (row * row + column);
    }
}

// ------------------------------------------------------------------------------------
// Mark: Equatable
// Implementing the Hashable protocol requires implementing the Equatable protocol
// ------------------------------------------------------------------------------------
func ==( lhs: Cell, rhs: Cell) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
