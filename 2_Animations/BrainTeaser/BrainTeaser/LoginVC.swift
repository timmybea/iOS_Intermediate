//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Tim Beals on 2017-05-31.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {

    @IBOutlet weak var emailCenterX: NSLayoutConstraint!
    @IBOutlet weak var passwordCenterX: NSLayoutConstraint!
    @IBOutlet weak var loginCenterX: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        animEngine = AnimationEngine(constraints: [emailCenterX, passwordCenterX, loginCenterX])
    }

    
    override func viewDidAppear(_ animated: Bool) {

        
        animEngine.animateOnScreen(delay: 2.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

