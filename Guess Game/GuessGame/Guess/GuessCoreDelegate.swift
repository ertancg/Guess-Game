//
//  GuessCoreDelegate.swift
//  GuessGame
//
//  Created by Ertan Can Güner on 14.10.2021.
//

import Foundation


protocol GuessCoreDelegate: AnyObject{
    
    func gameLost()
    func resetGame(difficulty: Bool)
    func littleHigher()
    func littleLower()
    func gameWon()
    func updateHealth(health: Int)
    func updateInfo(difficulty: Bool)
}
