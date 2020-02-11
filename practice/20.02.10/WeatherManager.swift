//
//  WeatherManager.swift
//  Clima
//
//  Created by shin seunghyun on 2020/02/10.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {

    let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather";
    let apiKey: String = "2a50132195767631db0cdfe509d8af9f"

    func fetchWeather(cityName: String){
        let urlString: String = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)"
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String){

        //1. Create URL
        if let url: URL = URL(string: urlString){

            //2. Create URLSession
            let session: URLSession = URLSession(configuration: .default)

            //3. Give the session a task
            let task: URLSessionDataTask = session.dataTask(with: url, completionHandler: handle)

            //4. Start the task
            task.resume()
        }

    }

    func handle(data: Data?, response: URLResponse?, error: Error?) {

        if (error != nil) {
            print(error!)
            return
        }

        if let safeData: Data = data {
            let dataString: String = String(data: safeData, encoding: .utf8)!
            print(dataString)
        }

    }


}