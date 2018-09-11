//
//  Cell.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/8/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation


struct Cell: CustomStringConvertible{
    
    // MARK: - Properties
    var coordinates: Coordinate
    var symbol: Character = "-"
    
    var description: String{
        return "\(symbol)"
    }
    
    init(coordinates: Coordinate, symbol: Character) {
        self.coordinates = coordinates
        self.symbol = symbol
    }
}
