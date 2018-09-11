//
//  Coordinates.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/8/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation


struct Coordinate: CustomStringConvertible{
    // MARK: - Properties
    var row: Int
    var col: Int
    var description: String{
        return "(\(row), \(col))"
    }
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    init(){
        self.row = 0
        self.col = 0
    }
}

