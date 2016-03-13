//
//  ViewController.swift
//  Mazes for Programmers
//
//  Created by Thomas Elders on 13/03/2016.
//  Copyright © 2016 Thomas Elders. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var ascii: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createBinaryTree(sender: NSButton) {
        print("Example: Chapter 1, Binary tree")
        let grid = Grid(rows: 5, columns: 5)
        let binaryTree = BinaryTree( grid: grid )
        print( binaryTree )
    }
    
    @IBAction func createSidewinder(sender: NSButton) {
        print("Example: Chapter 1, Sidewinder")
        let grid = Grid(rows: 5, columns: 5)
        let sidewinder = Sidewinder( grid: grid )
        print( sidewinder )
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

