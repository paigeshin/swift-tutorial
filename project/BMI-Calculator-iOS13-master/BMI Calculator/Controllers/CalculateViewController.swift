//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var caculatorBrain = CalculatorBrain()

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!

    var bmiValue:Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider){
        heightLabel.text = String(format: "%.2f", sender.value) + "m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.0f", sender.value) + "Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height:Float = heightSlider.value
        let weight:Float = weightSlider.value
        
        caculatorBrain.calculateBMI(height: height, weight: weight)
        //화면 넘기기
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    //화면 넘기기 전에 보내줄 데이터를 initialize
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Safety Check.
        if (segue.identifier == "goToResult") {
            let destinationVC = segue.destination as! ResultViewController //Down Casting
            destinationVC.bmiValue = caculatorBrain.getBMIValue()//다음 화면에 있는 value
            destinationVC.advice = caculatorBrain.getAdvice()
            destinationVC.color = caculatorBrain.getColor()
        }
    }
    

}

