import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    let weatherManager: WeatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        //UITextFieldDelegate 등록
        searchTextField.delegate = self
        
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

    //유저가 enter 키를 누름
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }

    //유저가 넣은 값을 validation 해준다`
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
        searchTextField.text = ""

    }
    
    
}




