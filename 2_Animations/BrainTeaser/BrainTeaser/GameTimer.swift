//
//  GameTimer.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-06-07.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation

protocol GameTimerDelegate {
    func timerDidStart()
    func timerDidChangeTime(timeString: String)
    func timerReachedZero()
}

class GameTimer {
    
    var timer = Timer()
    var delegate: GameTimerDelegate?
    
    init(duration: Int) {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(didChangeTime), userInfo: nil, repeats: true)
    }
    
    @objc func didChangeTime() {

        let hello = "hello"
        
        if self.delegate != nil {
            self.delegate?.timerDidChangeTime(timeString: hello)
        }
    }
}
