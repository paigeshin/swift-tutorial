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

    func fetchWeather(cityName: String) {
        let urlString: String = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString: String = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {

        //1. create URL
        if let url: URL = URL(string: urlString) {

            //2. create a URLSession
            let session: URLSession = URLSession(configuration: .default)

            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if (error != nil) {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                //4. Data Handle
                if let safeData: Data = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString!)
                    if let weather: WeatherModel = self.parseJSON(safeData) {
//                        let weatherVC:WeatherViewController = WeatherViewController()
//                        weatherVC.didUpdateWeather(weather: weather)
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        //delegate design pattern을 사용하는 이유는, reusable 하게 만들기 위함이다.
                    }
                }
            }

            //5. start a task
            task.resume()

        }
    }

    //data mapping
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
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
