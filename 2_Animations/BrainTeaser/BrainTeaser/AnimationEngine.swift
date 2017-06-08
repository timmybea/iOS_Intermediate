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
    
    private class var screenRect: CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    class var offscreenRightPosition: CGPoint {
        return CGPoint(x: screenRect.width, y: screenRect.midY)
    }
    
    class var offscreenLeftPosition: CGPoint {
        return CGPoint(x: -screenRect.width, y: screenRect.midY)
    }
    
    class var centerScreen: CGPoint {
        return CGPoint(x: screenRect.midX, y: screenRect.midY)
    }
    
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    let ANIM_DELAY: Double = 0.8
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            originalConstants.append(con.constant)
            con.constant = AnimationEngine.offscreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Double?) {
        
        let setDelay = delay == nil ? ANIM_DELAY : delay!
        
        let time = DispatchTime.now() + setDelay
        
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            for index in 0..<self.constraints.count {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim?.toValue = self.originalConstants[index]
                moveAnim?.springSpeed = 12
                moveAnim?.springBounciness = 12
                
                //create a differing amount of drag for each element to get more variance in the animation.
                if index > 0 {
                    moveAnim?.dynamicsFriction += 10 + CGFloat(index)
                }
                
                
                let con = self.constraints[index]
                con.pop_add(moveAnim, forKey: "moveOnScreen")
            }
        })
    }
    
    static func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation?, Bool) -> Swift.Void)!) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim?.toValue = NSValue(cgPoint: position)
        moveAnim?.springSpeed = 8
        moveAnim?.springBounciness = 8
        moveAnim?.completionBlock = completion
        view.pop_add(moveAnim, forKey: "moveToPosition")
    }
    
}

