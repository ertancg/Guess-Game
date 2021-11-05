//
//  GuessCore.swift
//  GuessGame
//
//  Created by Ertan Can Güner on 14.10.2021.
//

import Foundation

class GuessCore{
    
    private var guess: Int
    private var attemps: Int
    private var difficulty: Bool
    weak var delegate: GuessCoreDelegate?

    //Initial values for the fields.
    init(){
        self.guess = Int.random(in: 0...10)
        self.attemps = 0
        self.difficulty = false
    }
    //Main Logic of the program. Compares the input from the user and the random number. Send the message to update the UI accordingly.
    func hotOrCold(playerGuess: Int){
        if playerGuess > self.guess{
            self.attemps -= 1
            self.delegate?.updateHealth(health: self.attemps)
            self.delegate?.littleLower()
        }else if playerGuess == self.guess{
            self.delegate?.gameWon()
        }else{
            self.attemps -= 1
            self.delegate?.updateHealth(health: self.attemps)
            self.delegate?.littleHigher()
        }
        if self.attemps == 0{
            self.delegate?.updateHealth(health: self.attemps)
            self.delegate?.gameLost()
        }
    }
    //Starting the game from scratch according to the difficulty setting the user selected.
    func startGame(difficulty: Bool){
        self.difficulty = difficulty
        if difficulty{
            self.attemps = 5
            self.guess = Int.random(in: 0...20)
            //DEBUG
            //print("Hard Mode: guess: \(self.attemps)")
            self.delegate?.resetGame(difficulty: true)
            self.delegate?.updateHealth(health: self.attemps)
            self.delegate?.updateInfo(difficulty: self.difficulty)
        }else{
            self.attemps = 3
            self.guess = Int.random(in: 0...10)
            //DEBUG
            //print("Easy Mode: guess: \(self.attemps)")
            self.delegate?.resetGame(difficulty: false)
            self.delegate?.updateHealth(health: self.attemps)
            self.delegate?.updateInfo(difficulty: self.difficulty)
        }
        
    }
    //Returns the games difficulty value.
    func getDifficulty() -> Bool{
        return self.difficulty
    }
    
    
    
    
    
}
