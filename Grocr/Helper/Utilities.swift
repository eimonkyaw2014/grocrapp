//
//  Utilities.swift
//  Grocr
//
//  Created by eimonkyaw on 7/9/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
class Utilities {

    static func styleTextField(_ textfield:UITextField) {
        // create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // remove border on textfield
        textfield.borderStyle = .none
        
        // add line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFillButton(_ button : UIButton) {
        // filled rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button : UIButton) {
        // hollow rounded cornor width
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-Z¥¥d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
