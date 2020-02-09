//
//  ResultControllerView.swift
//  BMI Calculator
//
//  Created by shin seunghyun on 2020/02/09.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultControllerView: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var bmi:String?
    var text:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmi ?? "0.0"
        textLabel.text = text ?? ""
    }

    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
}
