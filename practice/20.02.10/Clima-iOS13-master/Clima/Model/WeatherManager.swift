import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {

    let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather";
    let apiKey: String = "2a50132195767631db0cdfe509d8af9f"

    var delegate: WeatherManagerDelegate?

    func fetchWeather(cityName: String){
        print("fetchWeather Called")
        let urlString: String = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)"
        performRequest(urlString: urlString)
    }

    func fetchWeather(latitude:CLLocationDegrees, longitude:CLLocationDegrees){
        let urlString: String = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String){
        //1. Create URL
        if let url: URL = URL(string: urlString){
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url){(data, response, error) in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                //4. Data Handling
                if let safeData: Data = data {
                    if let weather: WeatherModel = self.parseJSON(safeData){
                        print("Weather Data: \(weather)")
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //5. Start the task
            task.resume()
        }
    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            print(weatherData)
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