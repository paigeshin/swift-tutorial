//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let TAG: String = "LoginViewController"
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        print("\(TAG) - loginPressed(UIButton) is called")
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authDataResult, error) in
            if let loginError:Error = error {
                print("\(self.TAG) - loginPressed(UIButton) - error happened while logging in the user: \(loginError)")
            } else {
                self.performSegue(withIdentifier: "loginToChat", sender: self)
            }
        } 
    }
    
    
}
