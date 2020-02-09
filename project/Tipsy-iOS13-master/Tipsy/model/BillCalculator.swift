//
// Created by shin seunghyun on 2020/02/09.
// Copyright (c) 2020 The App Brewery. All rights reserved.
//

import Foundation

struct BillCalculator {

    var totalBill: Float
    var tipPercentage: Float
    var numberOfPeople: Float

    init(totalBill: Float, tipPercentage: Float, numberOfPeople: Float) {
        self.totalBill = totalBill
        self.tipPercentage = tipPercentage
        self.numberOfPeople = numberOfPeople
    }

    mutating func getDividedPrice() -> Float {
        (totalBill + totalBill * tipPercentage) / numberOfPeople
    }

    mutating func getDescription() -> String {
        "Split between \(Int(numberOfPeople)), with \(tipPercentage * 100)%"
    }

}