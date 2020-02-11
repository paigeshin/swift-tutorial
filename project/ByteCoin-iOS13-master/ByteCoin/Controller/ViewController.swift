//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var coinManager: CoinManager = CoinManager()

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchData(currency: coinManager.currencyArray[row])
    }

}

extension ViewController: CoinManagerDelegate {

    func didUpdateCoinData(coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.moneyLabel.text = coinModel.currency
            self.currencyLabel.text = String(format: "%.2f", coinModel.rate)
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}
