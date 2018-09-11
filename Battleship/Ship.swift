//
//  Ship.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/8/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation

struct Ship {
    
    // MARK: - Properties
    var name: ShipType
    var length: Int
    var occupiedCells: [Cell]
    var symbol: Character
    var hits: Int
    
    init(name: ShipType, length: Int, occupiedCells: [Cell], symbol: Character, hits: Int) {
        self.name = name
        self.length = length
        self.occupiedCells = occupiedCells
        self.symbol = symbol
        self.hits = hits
    }
}
