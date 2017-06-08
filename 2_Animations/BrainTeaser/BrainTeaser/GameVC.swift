//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-06-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import pop

enum testOutcome: String {
    case correct = "correct"
    case incorrect = "wrong"
}

class GameVC: UIViewController, GameTimerDelegate {

    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentCard: Card!
    var previousCardImageName: String?
    var score: Int = 0
    
    var gameTimer: GameTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    private func initialSetup() {
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.centerScreen
        self.view.addSubview(currentCard)
    }

    @IBAction func yesPressed(sender: CustomButton) {
        
        if sender.titleLabel?.text == "YES" {
            let ans = checkSameImage()
            if ans {
                changeScore(increment: true)
            } else {
                changeScore(increment: false)
            }
        } else {
            titleLabel.text = "Does this image match the previous one?"
            gameTimer = GameTimer(duration: 60)
            gameTimer?.delegate = self
        }
        showNextCard()
    }
    
    @IBAction func noPressed(sender: CustomButton) {
        let ans = checkSameImage()
        if !ans {
            changeScore(increment: true)
        } else {
            changeScore(increment: false)
        }
        
        showNextCard()
    }

    private func checkSameImage() -> Bool {
        if previousCardImageName == currentCard.imageName {
            return true
        } else {
            return false
        }
    }
    
    private func changeScore(increment: Bool) {
        if increment {
            score += 1
            print("CORRECT! Score is \(score)")
            successImage.image = UIImage(named: testOutcome.correct.rawValue)
        } else {
            score -= 1
            print("INCORRECT! Score is \(score)")
            successImage.image = UIImage(named: testOutcome.incorrect.rawValue)

        }
    }

    let successImage: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        //imageView.image = UIImage(named: testOutcome.correct.rawValue)
        return imageView
    }()
    
    //Do not put data manipulation in your animation callbacks!
    private func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
            previousCardImageName = current.imageName
            currentCard = nil
            
            
            if successImage.image != nil {
                let origX = current.frame.maxX - successImage.frame.width
                let origY = current.frame.origin.y - successImage.frame.height - 10
                successImage.frame.origin = CGPoint(x: origX, y: origY)
                self.view.addSubview(successImage)
            } else {
                print("No image")
            }

            AnimationEngine.animateToPosition(view: cardToRemove, position: AnimationEngine.offscreenLeftPosition, completion: { (animation, finished) in
                cardToRemove.removeFromSuperview()
                self.successImage.removeFromSuperview()
            })
        }
        
        if let nextCard = createCardFromNib() {
            nextCard.center = AnimationEngine.offscreenRightPosition
            self.view.addSubview(nextCard)
            self.currentCard = nextCard

            if noBtn.isHidden {
                noBtn.isHidden = false
                yesBtn.setTitle("YES", for: .normal)
            }
            
            AnimationEngine.animateToPosition(view: nextCard, position: AnimationEngine.centerScreen, completion: { (animation, finished) in
                //
            })
            
        }
    }
    
    private func createCardFromNib() -> Card? {
        return Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as? Card
    }
    
    //MARK: GameTimer delegate methods
    func timerDidStart() {
        //
    }
    
    func timerReachedZero() {
        timeLabel.text = "00:00"
        timeLabel.textColor = UIColor.red
        self.gameTimer?.delegate = nil
        finalScore()
    }
    
    internal func timerDidChangeTime(timeString: String) {
        timeLabel.text = timeString
    }

    private func finalScore() {
        let message = "Your final score is \(score)"
        let alertController = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
        let playAgain = UIAlertAction(title: "Play Again?", style: .default) { (action) in
            //Do something
            self.previousCardImageName = nil
            self.score = 0
            self.yesBtn.setTitle("START", for: .normal)
            self.noBtn.isHidden = true
            self.titleLabel.text = "Remember this image"
            self.timeLabel.textColor = UIColor.black
            self.timeLabel.text = "01:00"
            self.successImage.image = nil
            self.initialSetup()
        }
        alertController.addAction(playAgain)
        
        present(alertController, animated: true)
    }
    
}
