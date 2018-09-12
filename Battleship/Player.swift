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
    var hiddenBoard: BattleshipBoard?
    var remainingShips: Int
    
    var hits: Int
    var misses: Int
    var totalShots: Int
    
    var statsDescription: String{
        var stats = ""
        stats += "Hits: \(hits)\n"
        stats += "Misses: \(misses)\n"
        stats += "Total Shots: \(totalShots)\n"
        stats += "Hits to Misses Ratio: \(hits/(hits + misses)*100)%"
        return stats
    }
    
    
    init(battleshipBoard: BattleshipBoard, ships: [Ship], hiddenBoard: BattleshipBoard?) {
        self.battleshipBoard = battleshipBoard
        self.ships = ships
        self.hiddenBoard = hiddenBoard
        self.hits = 0
        self.misses = 0
        self.totalShots = 0
        self.remainingShips = 5
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
    
    
    func makeMove(row: Int, col: Int, player: inout Player, attacking player2: inout Player, isHuman: Bool) -> Bool{
        if player2.battleshipBoard.grid[col][row].symbol == "*" || player2.hiddenBoard?.grid[col][row].symbol == "m"{
            print("(\(col),\(row)) has already been hit! Try again.")
            return false
        } else if player2.battleshipBoard.grid[col][row].symbol == "-"{
            print("(\(col),\(row)) is a miss!")
            player2.hiddenBoard?.grid[col][row].symbol = "m"
            player2.battleshipBoard.grid[col][row].symbol = "m"
            player.totalShots += 1
            player.misses += 1
            return true
        }
        else if (player2.battleshipBoard.grid[col][row].symbol == "c" || player2.battleshipBoard.grid[col][row].symbol == "b" || player2.battleshipBoard.grid[col][row].symbol == "r" || player2.battleshipBoard.grid[col][row].symbol == "s" || player2.battleshipBoard.grid[col][row].symbol == "d"){
            for ship in player2.ships{
                for i in 0...ship.occupiedCells.count-1{
                    if ship.occupiedCells[i].coordinates.row == row && ship.occupiedCells[i].coordinates.col == col && ship.occupiedCells[i].symbol != "*"{
                        
                        for i in 0...player2.ships.count-1{
                            if ship.name == player2.ships[i].name{
                                player2.ships[i].hits += 1
                            }
                        }
                        player.hits += 1
                        player.totalShots += 1
                        
                        // reveal ship
                        if ship.hits+1 == ship.length{
                            if isHuman {
                                for cell in ship.occupiedCells{
                                    let changeCol = cell.coordinates.col
                                    let changeRow = cell.coordinates.row
                                    player2.hiddenBoard?.grid[changeCol][changeRow].symbol = cell.symbol
                                    player2.battleshipBoard.grid[changeCol][changeRow].symbol = cell.symbol
                                }
                            }
                            player2.remainingShips -= 1
                            print("A \(ship.name) has been sunk!")
                        }else{
                        
                            player2.hiddenBoard?.grid[col][row].symbol = "*"
                            player2.battleshipBoard.grid[col][row].symbol = "*"
                            print("(\(col),\(row)) is a hit!")
                        }
                        return true
                    }
                }
            }
        }
        
        return true
    }
    
    
}
