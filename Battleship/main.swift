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
    for ship in ships {
        print("Please enter the starting cell and direction (h for horizontally or v for vertically) to place the \(ship). (ex: 0 2 h)")
        if let choice = readLine(){
            var rowInd = choice.startIndex
            var colInd = choice.index(choice.startIndex, offsetBy: 2)
            var directionInd = choice.index(choice.startIndex, offsetBy: 4)
            var shipPlaced = false
            while !shipPlaced{
                if player.placeShip(Int(String(choice[rowInd]))!, Int(String(choice[colInd]))!, choice[directionInd], shipType: ship, player: &player){
                    shipPlaced = true
                    print(player.battleshipBoard)
                }
                else {
                    print("Please enter the starting cell and direction (h for horizontally or v for vertically) to place the \(ship). (ex: D 2 h)")
                    if let choice = readLine(){
                        rowInd = choice.startIndex
                        colInd = choice.index(choice.startIndex, offsetBy: 2)
                        directionInd = choice.index(choice.startIndex, offsetBy: 4)
                        shipPlaced = false
                    }
                }
            }
            
        }
    }
}

func randomPlacement(playerManual: Bool){
    
}


gameLoop()
