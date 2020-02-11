import Foundation

protocol CoinManagerDelegate {

    func didUpdateCoinData(coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error)

}


struct CoinManager {

    // https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKey=34A1D30A-03B3-494A-A919-F079451F84E4

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "34A1D30A-03B3-494A-A919-F079451F84E4"

    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]

    var delegate: CoinManagerDelegate?

    func fetchData(currency: String) {

        if currencyArray.contains(currency) {
            let url = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
            performRequest(urlString: url)
        }

    }

    func performRequest(urlString: String) {
        if let url: URL = URL(string: urlString) {
            let session: URLSession = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let coinData: Data = data {
                    if let coin: CoinModel = self.parseJSON(coinData: coinData) {
                        self.delegate?.didUpdateCoinData(coinManager: self, coinModel: coin)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let currency: String = decodedData.asset_id_quote
            let rate: Double = decodedData.rate
            return CoinModel(currency: currency, rate: rate)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
