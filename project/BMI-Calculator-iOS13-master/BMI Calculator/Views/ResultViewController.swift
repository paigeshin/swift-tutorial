//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by shin seunghyun on 2020/02/07.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiValue: String? //nil일 수도 있기 때문에 optional 값을 준다.
    var advice: String?
    var color: UIColor?
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmiValue ?? "Please enter another value"
        adviceLabel.text = advice ?? "No advice provided"
        view.backgroundColor = color ?? UIColor.white
        
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}
