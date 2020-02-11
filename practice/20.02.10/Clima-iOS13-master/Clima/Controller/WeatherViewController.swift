import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager: WeatherManager = WeatherManager()
    let locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func updateWeatherButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    //유저가 enter 키를 누름
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }

    //유저가 넣은 값을 validation 해준다
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }

    //유저가 editing을 멈춘다
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.iconImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }

}
