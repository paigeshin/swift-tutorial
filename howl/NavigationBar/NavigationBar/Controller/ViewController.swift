//
//  ViewController.swift
//  NavigationBar
//
//  Created by shin seunghyun on 2020/02/24.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navLeftButton: UIBarButtonItem!
    var currentViewController: UIViewController?
    
    @IBOutlet weak var frameView: UIView!
    
    var positionValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navLeftButton.target = self.revealViewController()
        navLeftButton.action = Selector("revealToggle:")
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        
        if let position: String = positionValue {
            performSegue(withIdentifier: position, sender: self)
        }
        
    }

    @IBAction func navRightButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Mail", message: "도착한 메세지가 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
 
    
}

