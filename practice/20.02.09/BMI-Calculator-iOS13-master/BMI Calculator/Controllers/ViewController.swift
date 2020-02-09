//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!

    var bmi:String?
    var text:String?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.1f", sender.value) + "m"
    }
    
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.0f", sender.value) + "Kg"
    }


    @IBAction func calculateButtonPressed(_ sender: UIButton) {

        let bmiCalculator:BMICalculator = BMICalculator(height: heightSlider.value, weight: weightSlider.value)
        bmi = bmiCalculator.getBMI()
        text = bmiCalculator.getText()

        self.performSegue(withIdentifier: "goToResult", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "goToResult"){
            //이렇게 해주면 다음 화면에 선언 되어있는 변수들에 접근이 가능하다.
            let resultVC = segue.destination as! ResultControllerView
            resultVC.bmi = bmi
            resultVC.text = text
        }

    }


}

