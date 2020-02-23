//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTyping: Bool = true
    private var calculator: CalculatorLogic = CalculatorLogic()
    
    private var displayValue: Double {
        //Double로 값을 변환하기
        get {
            guard let number: Double = Double(displayLabel.text!) else {
                fatalError("This value can't be converted to Double") //숫자가 아닐 수 있다. 0,1,2 등은 괜찮지만, '.'은 double로 변환될 수 없다.
            }
            return number
        }
        //displayLabel에 값을 출력
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTyping = true
        calculator.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
        
    }
    
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numValue: String = sender.currentTitle {
            if isFinishedTyping {
                displayLabel.text = numValue
                isFinishedTyping = false
            } else {
                //소수점 핸들링
                if numValue == "."{
                    //int인지 double인지 확인하기
                    guard let currentDisplayValue = Double(displayLabel.text!) else {
                        fatalError("Cannot convert display label text to a Double!")
                    }
                    let isInt = floor(currentDisplayValue) == currentDisplayValue
                    if !isInt {
                        return; //Int일 때는 .을 붙여도 된다는 말임.
                    }
                }
                displayLabel.text = displayLabel.text! + numValue
            }
        }
        
        
    }
    
}

