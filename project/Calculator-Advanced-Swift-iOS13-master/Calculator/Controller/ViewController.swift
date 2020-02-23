//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

/*
 Step1 : Numbers Accumulated
 Step2 : Calculate Handling such as '+/-', 'AC', '%'"
 Step3 : '.' handling
 Step4 : Code refactoring using `Computed Properties`
 Step5 : Apply MVC Pattern
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTypingNumber: Bool = true
    private var calculator: CalculatorLogic = CalculatorLogic()
    
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue: String = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    guard let currentDisplayValue = Double(displayLabel.text!) else {
                        fatalError("Cannot convert display label text to a Double!")
                    }
                    let isInt: Bool = floor(currentDisplayValue) == currentDisplayValue   //소수점 값이 있는지 없는지를 통해서 int value인지 확인함
                    if !isInt {
                        return;
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }
    
}

