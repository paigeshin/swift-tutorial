//
//  BMICalculator.swift
//  BMI Calculator
//
//  Created by shin seunghyun on 2020/02/09.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct BMICalculator {

    var height: Float
    var weight: Float

    init(height: Float, weight: Float) {
        self.height = height
        self.weight = weight
    }

    func getBMI() -> String {
        String(format: "%.1f", weight / pow(height, 2))
    }

    func getText() -> String {
        let bmi = weight / pow(height, 2)
        if (bmi < 10) {
            return "Light"
        } else if (bmi >= 10 && bmi < 20) {
            return "Normal"
        } else if (bmi >= 20 && bmi < 30) {
            return "Heavy"
        } else {
            return "Bizarre"
        }
    }

}
