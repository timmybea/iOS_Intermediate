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
    var currentTime: Int
    
    init(duration: Int) {
        currentTime = duration
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(didChangeTime), userInfo: nil, repeats: true)
    }
    
    @objc func didChangeTime() {

        let minutes: Int = currentTime / 60
        let seconds: Int = currentTime % 60
        let secString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let minString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        let timeString = "\(minString):\(secString)"
        
        if self.delegate != nil {
            currentTime > 0 ? self.delegate?.timerDidChangeTime(timeString: timeString) : self.delegate?.timerReachedZero()
        }
        
        currentTime -= 1
    }
}
