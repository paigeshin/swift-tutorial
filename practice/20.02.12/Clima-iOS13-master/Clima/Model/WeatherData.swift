//
//  WeatherData.swift
//  Clima
//
//  Created by shin seunghyun on 2020/02/12.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//name, main - temp, weather - id, description
struct WeatherData: Codable {
    var name: String
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
}

struct Weather: Codable {
    var id: Int
    var description: String
}