//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-05-31.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

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
    }
}
