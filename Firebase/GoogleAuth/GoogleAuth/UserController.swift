//
//  UserController.swift
//  GoogleAuth
//
//  Created by shin seunghyun on 2020/02/27.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
        
    }
    

    

    
}
