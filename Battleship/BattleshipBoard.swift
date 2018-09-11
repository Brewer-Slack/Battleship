//
//  BattleshipBoard.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/8/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation

struct BattleshipBoard: CustomStringConvertible {
    
    // Mark: - Properties
    var numRows: Int
    var numCols: Int
    var grid = [[Cell]]()
    
    var description: String {
        let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        for i in 0..<grid.count{
            var line = ""
            
            for j in 0..<grid[i].count{
                if i == 0 && j == 0{
                    line += "  0 1 2 3 4 5 6 7 8 9"
                    line += " \nA "
                    line += grid[i][j].description
                    line += " "
                } else if i > 0 && j == 0{
                    line += alphabet[i] + " "
                    line += grid[i][j].description
                    line += " "
                }
                else {
                    line += grid[i][j].description
                    line += " "
                }
            }
            print(line)
        }
        
        
        return ""
    }
    
    
    init(numRows: Int, numCols: Int) {
        self.numRows = numRows
        self.numCols = numCols
        
        //https://stackoverflow.com/questions/35411306/swift-2d-array-initialisation-with-objects
        self.grid = (1...numRows).map { i in (1...numCols).map { j in Cell(coordinates: Coordinate(row: i, col: j), symbol: "-") } }
        
    }
}
