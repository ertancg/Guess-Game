//
//  ViewController.swift
//  GuessGame
//
//  Created by Ertan Can Güner on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var InputField: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var guessImageview: UIImageView!
    @IBOutlet weak var healthOutlet: UILabel!
    
    @IBOutlet weak var infoOutlet: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var difficultyOutlet: UISegmentedControl!
    
    let guessCore = GuessCore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessCore.delegate = self
        self.playAgainButton.alpha = 0
        self.InputField.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    //A selected segment to set the games difficulty.
    @IBAction func difficultyButton(_ sender: Any) {
        print("index: \(difficultyOutlet.selectedSegmentIndex)")
        switch difficultyOutlet.selectedSegmentIndex{
        case 0:
            self.guessCore.startGame(difficulty: false)
        case 1:
            self.guessCore.startGame(difficulty: true)
        default:
            break
        }
    }
    
    //Main button to input values as guesses.
    @IBAction func getInput(_ sender: Any) {
        self.difficultyOutlet.isUserInteractionEnabled = false
        if let input = self.InputField.text{
            self.guessCore.hotOrCold(playerGuess: Int(input) ?? 0)
            self.InputField.text = ""
        }
    }
    //Play again button to play again previously selected difficulty.
    @IBAction func playAgain(_ sender: Any) {
        self.guessCore.startGame(difficulty: self.guessCore.getDifficulty())
        self.difficultyOutlet.isUserInteractionEnabled = false
    }
    
}
extension ViewController: GuessCoreDelegate{
    //Protocol Implementation for game's LOST state.
    func gameLost(){
        self.startButton.setTitle("You Lost", for: .normal)
        self.guessImageview.image = UIImage(named: "fail")
        self.playAgainButton.alpha = 1
        self.startButton.alpha = 0
        self.difficultyOutlet.isUserInteractionEnabled = true
        self.InputField.isUserInteractionEnabled = true
    }
    //Protocol Implementation for game's WON state.
    func gameWon(){
        self.startButton.setTitle("You Won ", for: .normal)
        self.guessImageview.image = UIImage(named: "check")
        self.playAgainButton.alpha = 1
        self.startButton.alpha = 0
        self.difficultyOutlet.isUserInteractionEnabled = true
        self.InputField.isUserInteractionEnabled = true
    }
    //Protocol Implementation for notifying the user to guess a little higher.
    func littleHigher(){
        self.guessImageview.image = UIImage(named: "up")
        self.startButton.setTitle("Just a little higher.", for: .normal)
    }
    //Protocol Implementation for notifying the user to guess a little lower.
    func littleLower(){
        self.guessImageview.image = UIImage(named: "down")
        self.startButton.setTitle("Just a little lower.", for: .normal)
    }
    //Protocol Implementation for updating user's health.
    func updateHealth(health: Int){
        self.healthOutlet.text = "Health: \(health)"
    }
    //Protocol Implementation for updating the rules of the game.
    func updateInfo(difficulty: Bool) {
        if difficulty{
            self.infoOutlet.text = "Computer will pick \ra number between 0-20."
        }else{
            self.infoOutlet.text = "Computer will pick \ra number between 0-10."
        }
    }
    //Protocol Implementation for resetting the UI.
    func resetGame(difficulty: Bool) {
        guessImageview.image = nil
        self.InputField.isUserInteractionEnabled = true
        self.startButton.setTitle("Am I Close?", for: .normal)
        self.playAgainButton.alpha = 0
        self.startButton.alpha = 1
    }
}

