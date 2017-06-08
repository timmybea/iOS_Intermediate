//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-06-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController, GameTimerDelegate {



    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var currentCard: Card!
    
    var gameTimer: GameTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCard = createCardFromNib()

        currentCard.center = AnimationEngine.centerScreen
        self.view.addSubview(currentCard)
        
        
    }

    @IBAction func yesPressed(sender: CustomButton) {
        
        if sender.titleLabel?.text == "YES" {
            checkAnswer()
        } else {
            titleLabel.text = "Does this image match the previous one?"
            gameTimer = GameTimer(duration: 60)
        }
        showNextCard()
    }
    
    @IBAction func noPressed(sender: CustomButton) {
        checkAnswer()
        showNextCard()
    }

    private func checkAnswer() {
        //TO DO
        
    }

    
    //Do not put data manipulation in your animation callbacks!
    private func showNextCard() {
        
        if let current = currentCard {
            let cardToRemove = current
        
            currentCard = nil
            
            AnimationEngine.animateToPosition(view: cardToRemove, position: AnimationEngine.offscreenLeftPosition, completion: { (animation, finished) in
                
                cardToRemove.removeFromSuperview()
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
        //
    }
    
    internal func timerDidChangeTime(timeString: String) {
        print(timeString)
    }
    
    
}
