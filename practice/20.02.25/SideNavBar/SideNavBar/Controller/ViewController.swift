//
//  ViewController.swift
//  SideNavBar
//
//  Created by shin seunghyun on 2020/02/25.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segueClicked: String?
    @IBOutlet weak var navLeftButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navLeftButton.target = self.revealViewController()
        navLeftButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(((self.revealViewController()?.panGestureRecognizer())!))
        
        
        if let position = segueClicked {
            performSegue(withIdentifier: position, sender: self)
            print(position)
        }
    }

    @IBAction func navRightButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Mail", message: "도착한 메세지가 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

