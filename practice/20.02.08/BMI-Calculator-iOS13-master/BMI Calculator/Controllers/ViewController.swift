//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!

    var bmiValue: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.1f", sender.value) + "cm"
    }


    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.0f", sender.value) + "Kg"
    }

    @IBAction func calculateButtonClicked(_ sender: UIButton) {

        let height: Float = heightSlider.value
        let weight: Float = weightSlider.value
        let bmi: Float = weight / pow(height, 2)
        bmiValue = bmi

        self.performSegue(withIdentifier: "goToResult", sender: self)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "goToResult") {
            let destinationVC = segue.destination as! ResultController
            destinationVC.bmi = bmiValue
            destinationVC.resultText = "Your BMI"
        }

    }
}

