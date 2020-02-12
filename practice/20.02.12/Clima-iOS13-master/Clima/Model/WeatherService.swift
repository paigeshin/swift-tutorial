import Foundation
import CoreLocation

protocol WeatherServiceDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherService {

    let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather";
    let apiKey: String = "2a50132195767631db0cdfe509d8af9f"

    var delegate: WeatherServiceDelegate?

    func fetchWeather(cityName: String) {
        let urlString: String = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("latitude: \(latitude) , longitude: \(longitude)")
        let urlString: String = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {

        if let url: URL = URL(string: urlString) {
            let session: URLSession = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData: Data = data {
                    if let weather: WeatherModel = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }

    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id: Int = decodedData.weather[0].id
            let name: String = decodedData.name
            let temp: Double = decodedData.main.temp
            let weather: WeatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }


}
