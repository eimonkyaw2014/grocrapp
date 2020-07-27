//
//  LoginViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/9/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UISplitViewControllerDelegate {

   
    @IBOutlet weak var emailTextfield :UITextField!
    @IBOutlet weak var passwordTextfield :UITextField!
    @IBOutlet weak var loginButton :UIButton!
    @IBOutlet weak var errorLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElement()
        errorLabel.isHidden = true
    }
    
    func setupElement() {
        Utilities.styleFillButton(loginButton)
        Utilities.styleTextField(emailTextfield)
        Utilities.styleTextField(passwordTextfield)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(sender :Any) {
        // validate text fields
        let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines   )
        
        if email == "" || password == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter email and password", preferredStyle: .alert)
            let defaultAction =  UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
        }
        // signing  in the user
        Auth.auth().signIn(withEmail: email, password: password) {
            (result,err) in
            if err != nil {
//                self.errorLabel.isHidden = false
//                self.errorLabel.text = err!.localizedDescription
//                self.errorLabel.alpha = 1
                let alert = UIAlertController(title: "Error", message: "Please enter email and password", preferredStyle: .alert)
                let defaultAction =  UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.taskListViewController) as! TaskListTableViewController
                self.navigationController?.pushViewController(destination, animated: true)

            }
        }
    }
    
}
