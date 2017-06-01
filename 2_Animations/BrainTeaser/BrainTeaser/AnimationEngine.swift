//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-05-31.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    class var offscreenRightPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height / 2)
    }
    
    class var offscreenLeftPosition: CGPoint {
        return CGPoint(x: 0.0, y: UIScreen.main.bounds.height / 2)
    }
    

    
}

