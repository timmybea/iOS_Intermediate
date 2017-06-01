//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-05-31.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import pop

@IBDesignable

class CustomButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fontColor: UIColor = UIColor.white {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.tintColor = fontColor
        
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDown)
        self.addTarget(self, action: #selector(CustomButton.scaleToSmall), for: .touchDragEnter)
        self.addTarget(self, action: #selector(CustomButton.scaleAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(CustomButton.scaleDefault), for: .touchDragExit)
    }
    
    //MARK: Animation methods
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.95, height: 0.95))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleAnimationSmall")
    }

    func scaleAnimation() {
        
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0)) //This is the x and y velocity
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
        self.layer.pop_add(scaleAnim, forKey: "layerScaleDefaultAnimation")
        
        
        
    }
}
