//
// Created by shin seunghyun on 2020/02/10.
// Copyright (c) 2020 App Brewery. All rights reserved.
//

import Foundation

//Property name should match the json data precisely
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}