//
//  ViewController.swift
//  GoogleAuth
//
//  Created by shin seunghyun on 2020/02/27.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn() //이미 로그인 됬을 시에는 바로 넘어가게 설정 가능하다.
        
        Auth.auth().addStateDidChangeListener { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "Home", sender: self)
            }
        }
        
    }
    
    @IBAction func googleSinginButtonPressed(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
        
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if(error != nil){
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                    self.performSegue(withIdentifier: "Home", sender: self)
                }
                return
            } else {
                let alert = UIAlertController(title: "알림", message: "회원가입완료", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

        }
    }
    
    
}


