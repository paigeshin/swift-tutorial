//
// Created by shin seunghyun on 2020/02/09.
// Copyright (c) 2020 Angela Yu. All rights reserved.
//

import UIKit

class ResultController: UIViewController {

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    var bmi:Float?
    var resultText:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.text = String(format: "%.1f", bmi ?? 0.0)
        resultLabel.text = resultText ?? "try again"

    }

    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

