//
//  Card.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-06-03.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

@IBDesignable
class Card: UIView {

    let shapes = ["shape1", "shape2", "shape3"]
    
    var currentShape: String!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0.8 {
        didSet {
            setupView()
        }
    }

    
    
    
    override func awakeFromNib() {
        self.setupView()
        selectShape()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    
    private func setupView() {

        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor  = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1).cgColor
        
        self.layer.cornerRadius = self.cornerRadius
        
        self.setNeedsLayout()
    }
    
    
    func selectShape() {
        var currentShape = shapes[Int(arc4random_uniform(3))]
        imageView.image = UIImage(named: currentShape)
        
    }

    
}
