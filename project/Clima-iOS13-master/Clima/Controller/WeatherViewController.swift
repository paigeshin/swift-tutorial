//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager:WeatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }

    // User Pressed Return Button on Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }

    // User Input Validation
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }

    // User Stopped Editing
    func textFieldDidEndEditing(_ textField: UITextField) {

        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }

        searchTextField.text = ""
    }

}

