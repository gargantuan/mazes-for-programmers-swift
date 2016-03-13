//
//  Sidewinder.swift
//  Mazes for Programmers
//
//  Created by Thomas Elders on 13/03/2016.
//  Copyright © 2016 Thomas Elders. All rights reserved.
//

import Foundation

class Sidewinder : CustomStringConvertible {

    let grid:Grid
    
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
    
    init( grid:Grid ){
        
        self.grid = grid;
        
        for row in self.grid.eachRow {
            
            var run:[Cell] = []
            
            for cell in row {
                
                run.append(cell)
                
                let atEasternBoundary = cell.east != nil ? false : true
                let atNortherBoundary = cell.north != nil ? false : true
                let shouldCloseOut = atEasternBoundary || ( !atNortherBoundary && Int(arc4random_uniform(2)) == 0 )
                
                if shouldCloseOut {
                    let member = run.randomItem()
                    if let northernNeighbour = member.north {
                        member.linkCell(northernNeighbour)
                    }
                    run.removeAll()
                }else{
                    if let easterNeighbour = cell.east {
                        cell.linkCell(easterNeighbour)
                    }
                }
                
            }
            
        }
        
    }

}