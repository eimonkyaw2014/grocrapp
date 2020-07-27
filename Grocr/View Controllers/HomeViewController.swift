//
//  HomeViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/9/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logout(sender :AnyObject) {
        let firebase = Auth.auth()
        do {
            try firebase.signOut()
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController)
                       present(vc, animated: true, completion: nil)
        } catch let err as NSError {
            print("Error %s", err)
        }
    }

}
