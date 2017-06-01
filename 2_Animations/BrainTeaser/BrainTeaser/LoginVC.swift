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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

    }

    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 4) {
            self.loginCenterX.constant = -100
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

