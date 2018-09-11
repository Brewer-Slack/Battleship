//
//  main.swift
//  Battleship
//
//  Created by Slack, Brewer Jay on 9/8/18.
//  Copyright © 2018 Slack, Brewer Jay. All rights reserved.
//

import Foundation


// TODO: COMMENT ABOVE DIFFERENT CLASS DECLARATIONS

// MARK - Properties
let ships = [ShipType.Carrier, ShipType.Battleship, ShipType.Cruiser, ShipType.Submarine, ShipType.Destroyer]
var numRows: UInt32 = 10

var computerBoard = BattleshipBoard(numRows: 10, numCols: 10)
var playerBoard = BattleshipBoard(numRows: 10, numCols: 10)
var playerShips = [Ship]()
var computerShips = [Ship]()

var player = Player(battleshipBoard: playerBoard, ships: playerShips)
var computer = Player(battleshipBoard: computerBoard, ships: computerShips)

func gameLoop() {
    print("Welcome to Battleship!")
    print("")
    rules()
    menu()
    
}

func rules(){
    print("Rules of the Game:")
    print("1. This is a two player game.")
    print("2. Player1 is you and Player2 is the computer.")
    print("ADD MORE RULES PLS OK THX")
    
    print("Press enter to start the game!")
    readLine()
}

func menu(){
    print("Please select from the following menu:")
    print("1. Enter positions of ships manually.")
    print("2. Allow the program to randomly select positions of ships.")
    print("")
    
    let choice = readLine()
    if choice == "1"{
        manualPlacement()
    } else{ // choice == 2
        randomPlacement(playerManual: false)
    }
}

func manualPlacement(){
    var decision = ""
    for ship in ships {
        print(player.battleshipBoard)
        print("Please enter the starting cell and direction (h for horizontally or v for vertically) to place the \(ship). (ex: D 2 h)")
        print("")
        if let choice = readLine(){
            decision = choice
            var rowInd = decision.startIndex
            var colInd = decision.index(decision.startIndex, offsetBy: 2)
            var directionInd = decision.index(decision.startIndex, offsetBy: 4)
            var shipPlaced = false
            while !shipPlaced{
                if player.placeShip(Int(String(decision[rowInd]))!, Int(String(decision[colInd]))!, decision[directionInd], shipType: ship, player: &player){
                    shipPlaced = true
                }
                else {
                    print(player.battleshipBoard)
                    print("Please enter the starting cell and direction (h for horizontally or v for vertically) to place the \(ship). (ex: D 2 h)")
                    print("")
                    if let choice = readLine(){
                        decision = choice
                        rowInd = decision.startIndex
                        colInd = decision.index(decision.startIndex, offsetBy: 2)
                        directionInd = decision.index(decision.startIndex, offsetBy: 4)
                        shipPlaced = false
                    }
                }
            }
            
        }
    }
    print(player.battleshipBoard)
    
    var rowInd: UInt32 = 0
    var colInd: UInt32 = 0
    var vertOrHorizInt: UInt32 = 0
    var vertOrHoriz: Character
    
    for ship in ships {
        print("placing computer ships")
        rowInd = arc4random_uniform(numRows-1)
        colInd = arc4random_uniform(numRows-1)
        vertOrHorizInt = arc4random_uniform(2)
        
        if vertOrHorizInt == 1{
            vertOrHoriz = "v"
        } else {
            vertOrHoriz = "h"
        }
        
        if computer.placeShip(Int(rowInd), Int(colInd), vertOrHoriz, shipType: ship, player: &computer){
            print("randomly placed computer ships successfully")
        } else {
            print("computer ships ran into an issue")
        }
    }
    
    
    
    
}

func randomPlacement(playerManual: Bool){
    if playerManual {
        
    }
}


gameLoop()
