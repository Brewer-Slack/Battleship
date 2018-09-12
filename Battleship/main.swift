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
var computerHiddenBoard = BattleshipBoard(numRows: 10, numCols: 10)
var playerBoard = BattleshipBoard(numRows: 10, numCols: 10)
var playerHiddenBoard = BattleshipBoard(numRows: 10, numCols: 10)
var playerShips = [Ship]()
var computerShips = [Ship]()

var player = Player(battleshipBoard: playerBoard, ships: playerShips, hiddenBoard: playerHiddenBoard)
var computer = Player(battleshipBoard: computerBoard, ships: computerShips, hiddenBoard: computerHiddenBoard)



func gameLoop() {
    rules()
    menu()
    startGame()
    print("Player 1 stats:")
    print(player.statsDescription)
    print("______________________")
    print("Player 2 stats:")
    print(computer.statsDescription)
    
}

func rules(){
    print("Welcome to Battleship!")
    print("")
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

func startGame(){
    var turn: Turn = decideStart()
    var rowInd: String.Index
    var colInd: String.Index
    var row: UInt32
    var col: UInt32

    while !checkGameOver() {
        if turn == Turn.player{
            print("Player 1's Board:")
            print(player.battleshipBoard)
            print("Player 2's Board:")
            print(computer.hiddenBoard!)
            
            print("board to cheat with")
            print(computer.battleshipBoard)
            
            print("")
            print("Enter a move. (ex D 2)")
            if let choice = readLine(){
                rowInd = choice.startIndex
                colInd = choice.index(choice.startIndex, offsetBy: 2)
                var moveMade = false
                while !moveMade{
                    if player.makeMove(row: Int(String(choice[rowInd]))!, col: Int(String(choice[colInd]))!, player: &player, attacking: &computer, isHuman: true) {
                        turn = Turn.computer
                        moveMade = true
                        
                    } else {
                        if let choice = readLine(){
                            rowInd = choice.startIndex
                            colInd = choice.index(choice.startIndex, offsetBy: 2)
                            moveMade = false
                        }
                    }
                }
            }
            
        } else {
            print("It is Player 2's turn!")
            row = arc4random_uniform(numRows)
            col = arc4random_uniform(numRows)
            
            if computer.makeMove(row: Int(row), col: Int(col), player: &computer, attacking: &player, isHuman: false) {
                
            }
            
            turn = Turn.player
        }
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
                if player.placeShip(Int(String(decision[rowInd]))!, Int(String(decision[colInd]))!, decision[directionInd], shipType: ship, player: &player, random: false){
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
    randomPlacement(playerManual: true)
    
}

func randomPlacement(playerManual: Bool){
    // if player manually placed pieces, randomly place computer pieces
    if playerManual {
        var rowInd: UInt32 = 0
        var colInd: UInt32 = 0
        var vertOrHorizInt: UInt32 = 0
        var vertOrHoriz: Character
        var shipPlaced = false
        
        for ship in ships {
            
            rowInd = arc4random_uniform(numRows)
            colInd = arc4random_uniform(numRows)
            vertOrHorizInt = arc4random_uniform(2)
            
            if vertOrHorizInt == 1{
                vertOrHoriz = "v"
            } else {
                vertOrHoriz = "h"
            }
            shipPlaced = false
            while !shipPlaced{
                if computer.placeShip(Int(rowInd), Int(colInd), vertOrHoriz, shipType: ship, player: &computer, random: true){
                    shipPlaced = true
                    
                } else {
                    
                    rowInd = arc4random_uniform(numRows)
                    colInd = arc4random_uniform(numRows)
                    vertOrHorizInt = arc4random_uniform(2)
                    if vertOrHorizInt == 1{
                        vertOrHoriz = "v"
                    } else {
                        vertOrHoriz = "h"
                    }
                    shipPlaced = false
                }
                
            }
        }
        // player is also placing randomly
    } else {
        var rowInd: UInt32 = 0
        var colInd: UInt32 = 0
        var vertOrHorizInt: UInt32 = 0
        var vertOrHoriz: Character
        var shipPlaced = false
        
        for ship in ships {            
            rowInd = arc4random_uniform(numRows)
            colInd = arc4random_uniform(numRows)
            vertOrHorizInt = arc4random_uniform(2)
            
            if vertOrHorizInt == 1{
                vertOrHoriz = "v"
            } else {
                vertOrHoriz = "h"
            }
            shipPlaced = false
            while !shipPlaced{
                if player.placeShip(Int(rowInd), Int(colInd), vertOrHoriz, shipType: ship, player: &player, random: true){
                    shipPlaced = true
                    
                } else {
                    
                    rowInd = arc4random_uniform(numRows)
                    colInd = arc4random_uniform(numRows)
                    vertOrHorizInt = arc4random_uniform(2)
                    if vertOrHorizInt == 1{
                        vertOrHoriz = "v"
                    } else {
                        vertOrHoriz = "h"
                    }
                    shipPlaced = false
                }
                
            }
        }
        for ship in ships {
            rowInd = arc4random_uniform(numRows)
            colInd = arc4random_uniform(numRows)
            vertOrHorizInt = arc4random_uniform(2)
            
            if vertOrHorizInt == 1{
                vertOrHoriz = "v"
            } else {
                vertOrHoriz = "h"
            }
            shipPlaced = false
            while !shipPlaced{
                if computer.placeShip(Int(rowInd), Int(colInd), vertOrHoriz, shipType: ship, player: &computer, random: true){
                    shipPlaced = true
                } else {
                    
                    rowInd = arc4random_uniform(numRows)
                    colInd = arc4random_uniform(numRows)
                    vertOrHorizInt = arc4random_uniform(2)
                    if vertOrHorizInt == 1{
                        vertOrHoriz = "v"
                    } else {
                        vertOrHoriz = "h"
                    }
                    shipPlaced = false
                }
                
            }
        }
    }
}

func checkGameOver() -> Bool {
    if player.remainingShips == 0 {
        print("Player 2 wins!")
        print("")
        return true
    } else if computer.remainingShips == 0 {
        print("Player 1 wins!")
        print("")
        return true
    } else {
        return false
    }
}

func decideStart() -> Turn {
    let randInt = arc4random_uniform(2)
    if randInt == 0{
        print("Player 1 will start!")
        return Turn.player
    } else {
        print("Player 2 will start!")
        return Turn.computer
    }
}


gameLoop()
