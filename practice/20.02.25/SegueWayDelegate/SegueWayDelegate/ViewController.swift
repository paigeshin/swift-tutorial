//
//  ViewController.swift
//  SegueWayDelegate
//
//  Created by shin seunghyun on 2020/02/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SecondViewProtocol {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "second", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondViewController
        secondVC.delegate = self
        secondVC.textFromFirst = "\(idTextField!.text!) is logged in"
    }
    
    func setNewText(newText: String) {
        label.text = newText
    }
    
    
    
    
}

