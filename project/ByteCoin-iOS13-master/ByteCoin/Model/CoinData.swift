//
// Created by shin seunghyun on 2020/02/11.
// Copyright (c) 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {

    let asset_id_base: String   //Bitcoin
    let asset_id_quote: String  //Currency
    let rate: Double            //Rate

}