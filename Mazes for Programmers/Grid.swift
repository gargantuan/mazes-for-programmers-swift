//
//  Grid.swift
//  Mazes for Programmers
//
//  Created by Thomas Elders on 13/03/2016.
//  Copyright © 2016 Thomas Elders. All rights reserved.
//

import Foundation

class Grid {
    
    let rows: Int
    let columns: Int
    var grid = [[Cell]]()
    
    var size: Int {
        return self.rows * self.columns
    }
    
    var eachRow: AnyGenerator<[Cell]> {
        var lastIteration = 0
        
        return anyGenerator({
            guard lastIteration < self.rows else {
                return nil
            }
            
            let next = self.grid[lastIteration] as [Cell]
            lastIteration++
            return next
            
        })
    }
    
    var eachCell: AnyGenerator<Cell> {

            
        var rowIndex = 0;
        var columnIndex = 0;
        
        return anyGenerator({
            
            guard rowIndex < self.rows else {
                return nil
            }
            
            guard columnIndex < self.columns else {
                return nil
            }
                            
            let nextCell = self.grid[rowIndex][columnIndex]
            
            columnIndex++
            
            if( columnIndex == self.columns ){
                columnIndex = 0
                rowIndex++
            }
            
            return nextCell
            
        })

    }
    
    init (rows: Int, columns:Int) {
        self.rows = rows;
        self.columns = columns
        
        self.grid = self.prepareGrid()
        self.configureCells()
    }
    
    func prepareGrid() -> [[Cell]] {
        
        var tempGrid:[[Cell]] = [];

        for rowIndex in 0 ..< self.rows {
            
            var rowArray:[Cell] = [];
            
            for columnIndex in 0 ..< self.columns {
                let newCell = Cell( row: rowIndex, column: columnIndex )
                rowArray.append(newCell)
            }

            tempGrid.append(rowArray)
        
        }
        
        return tempGrid
    }
    
    func configureCells() {
        for row in grid {
            for cell in row {
                
                let northInBounds = cell.row - 1 		> -1;
                let southInBounds = cell.row + 1 		< rows;
                let eastInBounds = cell.column + 1      < columns;
                let westInBounds = cell.column - 1      > -1;
                
                cell.north = northInBounds ? grid[ cell.row - 1 ][ cell.column ] : nil
                cell.south = southInBounds ? grid[ cell.row + 1 ][ cell.column ] : nil
                cell.east = eastInBounds ? grid[ cell.row ][ cell.column + 1] : nil
                cell.west = westInBounds ? grid[ cell.row ][ cell.column - 1] : nil

            }
        }
    }
    
    func cellAtGridPosition( row: Int, column: Int) -> Cell? {

        if let cell = grid[safe: row]?[safe: column] as Cell? {
            return cell
        }else{
            return nil
        }
    
    }
    
    func randomCell() -> Cell {
        return grid.randomItem().randomItem()
    }
    
}


extension Array {
    
    subscript (safe index: Int) -> Element? {
        // Safe (bounds-checked) array lookup in Swift
        // http://stackoverflow.com/a/30593673
        return indices.contains(index) ? self[index] : nil
    }
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}