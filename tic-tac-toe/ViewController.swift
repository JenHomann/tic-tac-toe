//
//  ViewController.swift
//  tic-tac-toe
//
//  Created by Jen Homann on 12/6/17.
//  Copyright © 2017 Jen Homann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var activePlayer = 1
    var activeGame = true
    var gameState = [0,0,0,0,0,0,0,0,0] // 0 - empty, 1 - noughts, 2 - crosses
    var winningCombos = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && activeGame {
            gameState[activePosition] = activePlayer
            if isFirstPlayer() {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
        } else {
            // report out that the spot has already been taken
        }
        
        checkForWinner()
        
        if !activeGame {
            winnerLabel.text = "Player \(activePlayer) wins!"
            animateEndOfGame()
        }
    }
    
    @IBAction func resetGame(_ sender: Any) {
        gameState = [0,0,0,0,0,0,0,0,0]
        activePlayer = 1
        activeGame = true
        
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        hideLabels()
    }
    
    func isFirstPlayer() -> Bool {
        return activePlayer == 1
    }
    
    func checkForWinner() {
        for combo in winningCombos {
            let first = gameState[combo[0]]
            let second = gameState[combo[1]]
            let third = gameState[combo[2]]
            if first != 0 && first == second && second == third {
                activeGame = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideLabels()
    }
    
    func hideLabels() {
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y: playAgainButton.center.y)
    }
    
    func animateEndOfGame() {
        winnerLabel.isHidden = false
        playAgainButton.isHidden = false
        
        let labelCenter = self.winnerLabel.center
        let buttonCenter = self.playAgainButton.center
        
        UIView.animate(withDuration: 1) {
            self.winnerLabel.center = CGPoint(x: labelCenter.x + 500, y: labelCenter.y)
            self.playAgainButton.center = CGPoint(x: buttonCenter.x + 500, y: buttonCenter.y)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

