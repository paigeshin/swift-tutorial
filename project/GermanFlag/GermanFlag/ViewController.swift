//
//  ViewController.swift
//  GermanFlag
//
//  Created by shin seunghyun on 2020/02/23.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        flagUkraine()
    }
    
    func flagUkraine(){
        topView.backgroundColor = UIColor(red: 0, green:0, blue:1, alpha: 1)
        middleView.removeFromSuperview()
    }


}

