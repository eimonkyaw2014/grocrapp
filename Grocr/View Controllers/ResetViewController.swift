//
//  ResetViewController.swift
//  Grocr
//
//  Created by eimonkyaw on 7/14/20.
//  Copyright © 2020 eimonkyaw. All rights reserved.
//

import UIKit
import FirebaseAuth
class ResetViewController: UIViewController {

    @IBOutlet weak var passwordTextfield :UITextField!
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
    
    
    @IBAction func resetPassword(sender : AnyObject) {
        if passwordTextfield.text == "" {
            let alert = UIAlertController(title: "Oops!", message: "Please enter email", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
        else {
            Auth.auth().sendPasswordReset(withEmail: passwordTextfield.text!, completion: { (err) in
                var title = ""
                var message = ""
                if err != nil{
                    title = "Error"
                    message = err?.localizedDescription as! String
                }
                else {
                    title = "Success"
                    message = "Password reset email sent."
                    self.passwordTextfield.text = ""
                }
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
            })
        }
    }
}
