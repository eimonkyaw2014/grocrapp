//
//  ViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/9/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var signupButton : UIButton!
    @IBOutlet weak var loginButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElement()
    }
    func setupElement() {
        Utilities.styleFillButton(signupButton)
        Utilities.styleFillButton(loginButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
