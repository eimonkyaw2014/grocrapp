//
//  SignUpViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/9/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController, UISplitViewControllerDelegate {

    @IBOutlet weak var firstnameTextfield :UITextField!
    @IBOutlet weak var lastnameTextfield : UITextField!
    @IBOutlet weak var emailTextfield :UITextField!
    @IBOutlet weak var passwordTextfield :UITextField!
    @IBOutlet weak var signupButton :UIButton!
    @IBOutlet weak var errorLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupElement()
        self.errorLabel.isHidden = true
    }
    
    func setupElement() {
        Utilities.styleFillButton(signupButton)
        Utilities.styleTextField(firstnameTextfield)
        Utilities.styleTextField(lastnameTextfield)
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

    func validateFields() -> String? {
       
        // check all fields are filled in
        if firstnameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
//
//        //checked if password is secure
//        let cleanedPassword = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        if Utilities.isPasswordValid(cleanedPassword) == false {
//            // password is not secured
//            return "Please make sure your password  is at least 8 characters , contains a special  character and a number"
//        }
      return nil
   }
    
   @IBAction func SignupTapped(_ sender : Any) {
    
//        // validate field
        let error = validateFields()
        if error != nil {
            // there's  something wrong with the fields, show error message
            self.errorLabel.isHidden = false
            self.showError(error!)
        }
        else {
           // created cleaned version of the data
            let firstname = firstnameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastnameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             //create user
            
            Auth.auth().createUser(withEmail: email, password: password) { (result,err) in
                // check for error
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    // user was  created successfully

                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstname,"lastname":lastname,"uid":result!.user.uid]){(error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                }
            }
//            // transaction
           self.transitionToHome()
        }
        
    }
    
    
    func  showError(_ message : String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.taskListViewController) as! TaskListTableViewController
        self.navigationController?.pushViewController(destination, animated: true)
    }
   
}
