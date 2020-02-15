//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    let TAG: String = "RegisterViewController"
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        print("\(TAG) - registerPressed(UIButton) is called")
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authResult, error) in
            if let registerError: Error = error {
                print("\(self.TAG) - registerPressed(UIBUtton) - Error Happend while registering user: \(registerError)")
            } else {
                self.performSegue(withIdentifier: "registerToChat", sender: self)
            }
        }
    }
    
}
