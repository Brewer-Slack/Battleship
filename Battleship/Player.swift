//
//  Player.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/8/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation

// https://morgandavison.com/2016/02/26/prevent-array-index-out-of-range-error-in-swift/
extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

struct Player {
    
    // MARK: - Properties
    var battleshipBoard: BattleshipBoard
    var ships: [Ship]
    
    init(battleshipBoard: BattleshipBoard, ships: [Ship]) {
        self.battleshipBoard = battleshipBoard
        self.ships = ships
    }
    
    
    
    
    func placeShip(_ row: Int, _ col: Int, _ direction: Character, shipType: ShipType, player: inout Player, random: Bool) -> Bool {
        var length: Int
        var symbol:Character
        var shipArr =  [Cell]()
        
        switch shipType {
        case ShipType.Carrier:
            length = 5
            symbol = "c"
        case ShipType.Battleship:
            length = 4
            symbol = "b"
        case ShipType.Cruiser:
            length = 3
            symbol = "r"
        case ShipType.Submarine:
            length = 3
            symbol = "s"
        default:
            length = 2
            symbol = "d"
        }
        if direction == "h"{
            var terminate = 0
            var newRow = row + terminate
            let safeRow = row + length-1
            while terminate != length{
                if player.battleshipBoard.grid[safe:col]![safe:safeRow]?.symbol == nil {
                    if !random {
                        print("That placement is not on the board! Try again.")
                        print("")
                    }
                    return false
                } else if player.battleshipBoard.grid[col][newRow].description != "-"{
                    if !random {
                        print("That ship overlaps with another! Try again.")
                        print("")
                    }
                    terminate = length
                    return false
                } else{
                    player.battleshipBoard.grid[col][newRow].symbol = symbol
                    shipArr.append(Cell(coordinates: Coordinate(row: newRow, col: col), symbol: symbol))
                    terminate += 1
                    newRow += 1
                    
                }
            }
            
        } else { //direction == "v"
            var terminate = 0
            var newCol = col + terminate
            let safeCol = col + length-1
            while terminate != length{
                if player.battleshipBoard.grid[safe:safeCol]?[safe:row]!.symbol == nil{
                    if !random {
                        print("That placement is not on the board! Try again.")
                        print("")
                    }
                    return false
                } else if player.battleshipBoard.grid[newCol][row].description != "-"{
                    if !random {
                        print("That ship overlaps with another! Try again.")
                        print("")
                    }
                    terminate = length
                    return false
                } else{
                    player.battleshipBoard.grid[newCol][row].symbol = symbol
                    shipArr.append(Cell(coordinates: Coordinate(row: row, col: newCol), symbol: symbol))
                    terminate += 1
                    newCol += 1
                    
                }
            }
        }
        // add shipArr cells to ship here
        player.ships.append(Ship(name: shipType, length: length, occupiedCells: shipArr, symbol: symbol, hits: 0))
        return true
    }
    
    
    func makeMove(row: Int, col: Int, player: inout Player, attacking player2: inout Player) -> Bool{
        
    }
    
    
    
}
