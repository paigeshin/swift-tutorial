//
//  ViewController.swift
//  SegueWay
//
//  Created by shin seunghyun on 2020/02/24.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NextProtocol {


    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        message.text = ""
        
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToNext", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NextViewController
        destinationVC.delegate = self
        destinationVC.user = id.text
        
    }
    
    func sendStringFromNextViewToMainView(str: String) {
       
        message.text = "\(str) Power Text Logged Out"
     
    }
    
    
}

