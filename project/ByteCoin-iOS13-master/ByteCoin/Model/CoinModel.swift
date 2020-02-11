//
// Created by shin seunghyun on 2020/02/11.
// Copyright (c) 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {

    var currency: String
    var rate: Double

    init(currency: String, rate: Double){
        self.currency = currency
        self.rate = rate
    }

}