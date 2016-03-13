//
//  BinaryTree.swift
//  Mazes for Programmers
//
//  Created by Thomas Elders on 13/03/2016.
//  Copyright © 2016 Thomas Elders. All rights reserved.
//

import Foundation

func stringMultiplication( pattern: String, factor: Int ) -> String {
    var output = "";
    for _ in 0 ..< factor {
        output += pattern
    }
    return output;
}

class BinaryTree : CustomStringConvertible {

    let grid: Grid
    
    var description: String {
        get {
            var output = "+" + stringMultiplication( "---+", factor: self.grid.columns ) + "\n"
            
            for row in self.grid.eachRow {
                
                var top = "|"
                var bottom = "+"
                
                for cell in row {
                    
                    let body = "   " // three spaces
                    let eastBoundary:String = cell.isLinkedToCell(cell.east) ? " " : "|"
                    top += body + eastBoundary
                    
                    let southernBoundary = cell.isLinkedToCell(cell.south) ? "   " : "---"
                    let corner = "+"
                    
                    bottom += southernBoundary + corner
                    
                }
                
                
                output += top + "\n"
                output += bottom + "\n"
                
            }
            
            return output
        }
    }
    
    init( grid: Grid ){
        
        for cell in grid.eachCell {
            
            var neighbours:[Cell] = []
            
            if let north = cell.north {
                neighbours.append(north)
            }
            
            if let east = cell.east {
                neighbours.append(east)
            }
            
            if neighbours.count > 0 {
                let randomNeighbour = neighbours.randomItem()
                randomNeighbour.linkCell(cell)
            }
            
        }
        
        self.grid = grid;
        
    }

}