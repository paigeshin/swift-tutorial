//
//  NextViewController.swift
//  SegueWay
//
//  Created by shin seunghyun on 2020/02/24.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

protocol NextProtocol {
    
    func sendStringFromNextViewToMainView(str: String)
    
}

class NextViewController: UIViewController {
    
    var user: String?
    @IBOutlet weak var mainTitle: UILabel!
    
    var delegate : NextProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
            mainTitle.text = "\(user)님 환영합니다!"
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
 
        delegate?.sendStringFromNextViewToMainView(str: user!)
  
        dismiss(animated: true, completion: nil)
    }
    
    
}
