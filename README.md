# swift-tutorial
회사서 급하게 iOS가 필요하다고 해서 시작한 스터디

20.02.10

- function as a parameter
        
        func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
            return operation(n1, n2)
        }

        func add(no1: Int, no2: Int) -> Int {
            return no1 + no2
        }

        let result = calculator(n1: 7, n2: 3, operation: add)
        
- closure - anonymous function

        func calculator(n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
            return operation(n1, n2)
        }

        calculator(n1: 4, n2: 5, operation: { (no1: Int, no2: Int) -> Int in
            return no1 * no2
        })
        
- withoout datatype

        func calculator(n1: Int, n2: Int, opeartion: (Int, Int) -> Int) -> Int {
            return opeartion(n1, n2)
        }

        let result = calculator(n1: 2, n2: 3, opeartion: { (no1, no2) -> Int in 
         return no1 * no2 
        })

- in one line

        func calculator(n1: Int, n2: Int, opeartion: (Int, Int) -> Int) -> Int {
            return opeartion(n1, n2)
        }

        let result = calculator(n1: 2, n2: 3, opeartion: { (no1, no2) -> Int in no1 * no2 })
        
- anonymous parameter names using $  $0 → first parameter, $1 → second parameter

        func calculator(n1: Int, n2: Int, opeartion: (Int, Int) -> Int) -> Int {
            return opeartion(n1, n2)
        }
        
        let result = calculator(n1: 2, n2: 3, opeartion: { $0 * $1 })
        
- Map
    -❗️Swift에서 closure function 내부에 있는 내용이 함수에 접근하려면 self keyword를 붙여야 한다.

        let array = [1, 2, 3, 4, 5, 6]

        func addOne(n1: Int) -> Int {
                return n1 + 1
        }

        let normalArray = array.map(addOne)

        let newStringArray = array.map({"\($0)"})
        let newPlusArray = array.map({(n1:Int) -> Int in n1 + 1})


- SF Symbol
    - cloud.bolt 식으로 이름이 주어짐
    
            //Computed Properties
            var conditionName: String {
                switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }
            }

-SF Symbol 사용하는 방식

         self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        
- Computed Properties

            

20.02.09
- dark mode를 고려해서 제품을 만들 것

- Delegate Design Pattern
    - 내 식으로 풀어서 얘기하자면, 특정 protocol을 공유하는 것 중에 super class 또는 struct가 아래의 object에게 일을 위임함
    

                //Cetificate
                protocol AdvancedLifeSupport {
                    func performCPR()
                }

                class EmergencyCallHandler {
                    var delegate: AdvancedLifeSupport?
                    
                    func assessSituation(){
                        print("Can you tell me what happened?")
                    }
                    
                    func medicalEmergency(){
                        delegate?.performCPR()
                    }

                }

                struct Paramedic: AdvancedLifeSupport {
                    
                    init(handler: EmergencyCallHandler){
                        handler.delegate = self
                    }
                    
                    func performCPR() {
                        print("The paramedic does chest compressions, 30 per second.")
                    }
                }

                class Doctor: AdvancedLifeSupport {
                    
                    init(handler: EmergencyCallHandler) {
                        handler.delegate = self
                    }
                    
                    func performCPR() {
                        print("The doctor does chest compressions, 30 per second.")
                    }
                    
                    func useStethescope() {
                        print("Listening for heart sounds")
                    }
                    
                }

                class Surgeon: Doctor {
                    override func performCPR() {
                        super.performCPR()
                        print("Sings staying alive by the BeeGees")
                    }
                }

                let emilio = EmergencyCallHandler()
                let angela = Surgeon(handler: emilio)

                emilio.assessSituation()
                emilio.medicalEmergency()


- Delegate가 적용된 swift iOS 예시

            import UIKit

            class WeatherViewController: UIViewController, UITextFieldDelegate {

                @IBOutlet weak var conditionImageView: UIImageView!
                @IBOutlet weak var temperatureLabel: UILabel!
                @IBOutlet weak var cityLabel: UILabel!
                @IBOutlet weak var searchTextField: UITextField!

                var weatherManager:WeatherManager = WeatherManager()
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    searchTextField.delegate = self //이 부분이 delegate 부분이다
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

- Swift HTTP 통신 기본

            import Foundation

            struct WeatherManager {

                let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather";
                let apiKey: String = "2a50132195767631db0cdfe509d8af9f"

                func fetchWeather(cityName: String) {
                    let urlString: String = "\(weatherURL)?q=\(cityName)&appid=\(apiKey)"
                    performRequest(urlString: urlString)
                }

                func performRequest(urlString: String) {

                    //1. create URL
                    if let url: URL = URL(string: urlString) {

                        //2. create a URLSession
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
                        let dataString: String = String(data: safeData, encoding: .utf8)
                        print(dataString!)
                    }

                }

            }

- Computed Properties

            struct WeatherModel {
                let conditionId: Int
                let cityName: String
                let temperature: Double

                var temperatureString: String {
                    String(format: "%.1f", temperature)
                }

                //Computed Properties
                var conditionName: String {
                    switch conditionId {
                    case 200...232:
                        return "cloud.bolt"
                    case 300...321:
                        return "cloud.drizzle"
                    case 500...531:
                        return "cloud.rain"
                    case 600...622:
                        return "cloud.snow"
                    case 701...781:
                        return "cloud.fog"
                    case 800:
                        return "sun.max"
                    case 801...804:
                        return "cloud.bolt"
                    default:
                        return "cloud"
                    }
                }


            }
            
- Type Alias

            typealias Codable = Decodable & Encodable
            
- Parameter Names, external - internal 

            func myFunc(name: Type) {
                print(name)
            }
                
- DispatchQueue
    
            func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
                //UI에 데이터를 곧바로 업데이트 할 수 없다. => 안드로이드와 비슷함. Main Thread만 UI View에 접근할 수 있다.
                //Background로 UI를 update 해야한다.
                DispatchQueue.main.async { //closure
                    self.temperatureLabel.text = weather.temperatureString
                }
            }

- Extensions

            import UIKit

            extension Double {
                
                func round(to places: Int) -> Double {
                    let precisionNumber = pow(10, Double(places))
                    var n = self
                    n = n * precisionNumber
                    n.round()
                    n = n / precisionNumber
                    return n
                }
                
            }

            var myDouble = 3.14159

            myDouble.round(to: 3)
            
            
            import UIKit

            //let button = UIButton(frame: CGRect(x:0, y:0, width:50, height:50))
            //button.backgroundColor = .red
            //button.layer.cornerRadius = 25
            //button.clipsToBounds = true

            extension UIButton {
                func makeCircular(){
                    self.clipsToBounds = true
                    self.layer.cornerRadius = self.frame.size.width / 2
                }
            }

            let button = UIButton(frame:CGRect(x: 0, y: 0, width: 50, height: 50))
            button.backgroundColor = .red
            button.makeCircular()
            
- protocol extension

            protocol CanFly {
                    func fly()
            }

            extension CanFly {
                    func fly(){
                            print("The object takes off into the air")
                    }
            }
            
- extension을 이용한 코드 분할

            //
            //  ViewController.swift
            //  Clima
            //
            //  Created by Angela Yu on 01/09/2019.
            //  Copyright © 2019 App Brewery. All rights reserved.
            //

            import UIKit

            class WeatherViewController: UIViewController {

                @IBOutlet weak var conditionImageView: UIImageView!
                @IBOutlet weak var temperatureLabel: UILabel!
                @IBOutlet weak var cityLabel: UILabel!
                @IBOutlet weak var searchTextField: UITextField!

                var weatherManager: WeatherManager = WeatherManager()

                override func viewDidLoad() {
                    super.viewDidLoad()
                    weatherManager.delegate = self
                    searchTextField.delegate = self
                }

            }

            //Mark: - UITextFieldDelegate

            extension WeatherViewController: UITextFieldDelegate {

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
                    if (textField.text != "") {
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

            extension WeatherViewController: WeatherManagerDelegate {

                func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
                    //UI에 데이터를 곧바로 업데이트 할 수 없다. => 안드로이드와 비슷함. Main Thread만 UI View에 접근할 수 있다.
                    //Background로 UI를 update 해야한다.
                    DispatchQueue.main.async { //closure
                        self.temperatureLabel.text = weather.temperatureString
                        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                    }
                }

                func didFailWithError(error: Error) {
                    print(error)
                }

            }
            
- location

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

20.02.07

- print two decimal point

        String(format: "%2.f", value)

- no decimal point

        String(format: "%.0f", value)

- no decimal point

        Int(value)
        
- square number

        let bmi:Float = weight / pow(height, 2)

- override method
    - 굳이 super.method()를 호출하지 않아도 된다.
    - super class에서 정의된 method가 필요 없다는 뜻이다.

            override func move() {
                    print("Fly forwards")
                }
                
            override func attack() {
                super.attack()
                print("Spits Fire, does 10 damage")
            }

- struct vs class
        - struct can't inherit
        - class is passed by reference
        - class can copy 
        
    - `use structures by default`
    - use classes when you need Objective-C interporlability
    - use `classes` when you need to control `the identity of the data` you're modeling
    - use structures along with protocols to adopt behavior by sharing implementations
        
- multiple screen default

        let secondVC = SecondViewController()
        secondVC.bmiValue = String(format: "%.1f", bmi)
        self.present(secondVC, animated: true, completion: nil)

- multiple screen segue way
        
    - 첫 번째 화면
    - segue에 id값을 준 뒤에
    -  `self.performSegue(withIdentifier: "goToResult", sender: self)
    - 보내줄 값이 있으면 `override prepare` 
    
            import UIKit

            class CalculateViewController: UIViewController {

                @IBOutlet weak var heightLabel: UILabel!
                @IBOutlet weak var weightLabel: UILabel!
                @IBOutlet weak var heightSlider: UISlider!
                @IBOutlet weak var weightSlider: UISlider!

                var bmiValue:Float = 0
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    // Do any additional setup after loading the view.
                }

                @IBAction func heightSliderChanged(_ sender: UISlider){
                    heightLabel.text = String(format: "%.1f", sender.value) + "m"
                }
                
                @IBAction func weightSliderChanged(_ sender: UISlider) {
                    weightLabel.text = String(format: "%.0f", sender.value) + "Kg"
                }
                
                @IBAction func calculatePressed(_ sender: UIButton) {
                    let height:Float = heightSlider.value
                    let weight:Float = weightSlider.value
                    
                    let bmi:Float = weight / pow(height, 2)
                    bmiValue = bmi
                    
                    //화면 넘기기
                    self.performSegue(withIdentifier: "goToResult", sender: self)
                }
                
                //화면 넘기기 전에 보내줄 데이터를 initialize
                override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    //Safety Check.
                    if (segue.identifier == "goToResult") {
                        let destinationVC = segue.destination as! ResultViewController //Down Casting
                        destinationVC.bmiValue = String(format: "%.1f", bmiValue) //다음 화면에 있는 value
                    }
                }
                

            }
            
    - 두 번째 화면, 받는 값
    
            import UIKit

            class ResultViewController: UIViewController {
                
                var bmiValue: String? //nil일 수도 있기 때문에 optional 값을 준다.

                @IBOutlet weak var bmiLabel: UILabel!
                @IBOutlet weak var adviceLabel: UILabel!
                
                override func viewDidLoad() {
                    super.viewDidLoad()
                    if(bmiValue != nil){
                        bmiLabel.text = bmiValue
                    }
                }
                
                @IBAction func recalculatePressed(_ sender: UIButton) {
                    self.dismiss(animated: true, completion: nil)
                }


            }
            
- Swift Downcasting

            
            let destinationVC = segue.destination as! ResultViewController //이렇게 해줘야 다음 화면의 변수에 값을 지정해줄 수 있다.
            
            
- Optional Deep
        
    -1. Unrwap
            
            value!
        
    -2. check for nil value
    
        if(value != nil){
            value!
        }

    -3. Optional Binding
    
        if let safeValue = optional {
            safeValue
        }

    -4. optional ?? default
    
        value ?? defaultValue
        
    -5. Optional Chaining (for class and structure)
        
        optional?.property
        optional?.method()    //If this optional isn't `nil`, continue

20.02.06

- Structure

        struct Town {

            let name = "ShinLand"
            var citizens = ["Shin", "Jack Bauer"]
            var resources = ["Grain": 100, "Ore": 42, "Wool": 75]
            
            func fortify(){
                print("Defences increased!")
            }

        }

- initializer

        struct Town {
            let name : String
            var citizens : [String]      //Array
            var resources : [String:Int] //Dictionary
            
            init(name: String, citizens: [String], resources: [String:Int]){
                    self.name = name
                    self.citizens = citizens
                    self.resources = resources
            }
        
            func fortify(){
                    print("Defences Increased!")
            }
        
        }
        
        var anotherTown = 
        Town(
        townName: "Nameless Island", 
        people: ["Tom Hanks"], 
        stats: ["Coconuts": 100]
        )
        
- Delay

        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

        @objc func updateUI() {
                questionLabel.text = quiz[questionNumber].question
                trueButton.backgroundColor = UIColor.clear
                falseButton.backgroundColor = UIColor.clear
            }
            
- Quiz Game

            import UIKit

            class ViewController: UIViewController {

                @IBOutlet weak var questionLabel: UILabel!
                @IBOutlet weak var progressBar: UIProgressView!
                @IBOutlet weak var trueButton: UIButton!
                @IBOutlet weak var falseButton: UIButton!

                let quiz = [
                    Question(q: "A slug's blood is green.", a: "True"),
                    Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
                    Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
                    Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
                    Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
                    Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
                    Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
                    Question(q: "Google was originally called 'Backrub'.", a: "True"),
                    Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
                    Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
                    Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
                    Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
                ]

                var questionNumber = 0
                var totalQuestion = 0

                override func viewDidLoad() {
                    super.viewDidLoad()

                    totalQuestion = quiz.count

                    updateUI()
                }

                @IBAction func answerButtonPressed(_ sender: UIButton) {

                    let userAnswer = sender.currentTitle!
                    let actualAnswer = quiz[questionNumber].answer

                    if (userAnswer == actualAnswer) {
                        sender.backgroundColor = UIColor.green
                    } else {
                        sender.backgroundColor = UIColor.red
                    }

                    if (questionNumber < quiz.count - 1) {
                        questionNumber += 1
                    } else {
                        questionNumber = 0
                        progressBar.setProgress(0, animated: true)
                    }

                    Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

                }


                @objc func updateUI() {
                    questionLabel.text = quiz[questionNumber].question
                    trueButton.backgroundColor = UIColor.clear
                    falseButton.backgroundColor = UIColor.clear

                    let progressValue : Float = Float(questionNumber + 1) / Float(totalQuestion)
                    progressBar.setProgress(progressValue, animated: true)
                    print("\(progressValue) : current value")
                }

            }


- Parameter name not required

            func checkAnswer(_ userAnswer: String){
                            
            }
            
- Internal - External Parameter

            func checkAnswer(answer userAnswer: String){
                    //userAnswer이란 parameter name으로 접근 가능 
                    //answer - external parameter
                    //userAnswer - internal parameter 
            }

- return 값이 있는 함수

            func checkAnswer(_ userAnswer: String) -> Bool {

                if (userAnswer == quiz[questionNumber].answer) {
                    return true
                } else {
                    return false
                }

            }

- struct 내부의 변수 값 변경


            //mutating
            mutating func increment(){
                if(questionNumber + 1 < quiz.count){
                    questionNumber += 1
                } else {
                    questionNumber = 0
                }
            }

20.02.05

- Linking multiple elements to one IBAction


- Function insdie of Function

        func greeting1(){
            print("Hello")
            
            func greeting2(){
                print("Hey")
            }

        }
        
- Linking multiple elements to a single action
    -@IB, interface connection part
    -기본적으로 swift element들에 여러가지 property에 접근할 수 있다.
        -example)
            
        sender.titleLabel.text
    
        @IBAction func keyPressed(_ sender: UIButton) {
            
            print(sender.titleLabel?.text);
            
            playSound()
            
        }
        
- Type Differences
    - input
    - swift specific grammer: `func myFunction(parameter: DataType){ }`


- Play Sound

        import UIKit
        import AVFoundation

        class ViewController: UIViewController {

            var player: AVAudioPlayer!
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
            }

            @IBAction func keyPressed(_ sender: UIButton) {
                
                playSound(note: sender.currentTitle!)
                print("\(sender.currentTitle!) is played")
                sender.imageView?.backgroundColor?.withAlphaComponent(0.5)
                
            }
            
            func playSound(note: String){
                let url = Bundle.main.url(forResource: note, withExtension: "wav")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
            
            
        }

- Creating Function
        
            var myAge:Int = 12
        
            func getMilk(bottles int){
                var cost = bottles * 1.5
            }
        
- Call Function

            getMilk(bottles: 2);

- String interpretatoin

            func greeting(whoToGreet: String){
                print("Hello \(whoToGreet)");
            }
            
            gretting(whoToGreet: "Anyone");
            
- current title
            
            note: sender.currentTitle!
            
- alpha color

            sender.imageView?.backgroundColor?.withAlphaComponent(0.5)
            
- Swift switch Statement
"Swift는 `switch`를 사용할 때, `break` keyword가 필요가 없다."

                let score = Int.random(in: 0...100)

                switch score {
                    case 81...100:

                    case 41..<81:

                    case ...40:

                    default


                }

- Dictionary

                let eggtimes = ["Soft" : 5, "Medium" : 7, "Hard" : 12]


=> Dictionary 사용 전

                import UIKit

                class ViewController: UIViewController {
                    
                    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 9]

                    @IBAction func eggClicked(_ sender: UIButton) {
                        
                        let hardness = sender.currentTitle
                        
                            
                        switch hardness {
                        case "Soft":
                            print(eggTimes["Soft"]!);
                        case "Medium":
                            print(eggTimes["Medium"]!);
                        case "Hard":
                            print(eggTimes["Hard"]!);
                        default: break
                        
                        }
                        
                        
                    }
                    
                }

=> Dictionary 적용 후

                import UIKit

                class ViewController: UIViewController {
                    
                    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

                    var secondsRemaining = 60;

                   
                    @IBAction func eggClicked(_ sender: UIButton) {
                        let hardness = sender.currentTitle!
                        secondsRemaining = eggTimes[hardness]!
                        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
                    }
                    
                    @objc func updateTimer(){
                        if secondsRemaining > 0 {
                            print("\(secondsRemaining) seconds.")
                            secondsRemaining -= 1
                        }
                        
                    }
                }
                
- Optionals
    - `?`는 nil 값을 허용
    
              var player1UserName : String? = nil
    
    -`!`는 optional을 unwrap 해준다.
    
            var unwrappedP1Username = player1Username!  
        
    - safety check
    
            if player1Username != nil {
                print(player1Username!);
            }
            
    

- Timer Version 1

import UIKit

    class ViewController: UIViewController {
        
        let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

        var secondsRemaining = 60;

       
        @IBAction func eggClicked(_ sender: UIButton) {
            let hardness = sender.currentTitle!
            secondsRemaining = eggTimes[hardness]!
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
        }
        
        @objc func updateTimer(){
            if secondsRemaining > 0 {
                print("\(secondsRemaining) seconds.")
                secondsRemaining -= 1
            }
            
        }
    }

- Timer Version 2

        import UIKit

        class ViewController: UIViewController {
            
            let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]

            @IBOutlet weak var textLabel: UILabel!
            var secondsRemaining = 60;
            var timer = Timer();
            
            @IBAction func eggClicked(_ sender: UIButton) {
                    textLabel.text = "How do you like your eggs?"
                timer.invalidate()
                let hardness = sender.currentTitle!
                secondsRemaining = eggTimes[hardness]!
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
            
            @objc func updateTimer(){
                if secondsRemaining > 0 {
                    print("\(secondsRemaining) seconds.")
                    secondsRemaining -= 1
                } else {
                    timer.invalidate();
                    textLabel.text = "done";
                }
            }
        }
        
- Timer Version 3

        import UIKit

        class ViewController: UIViewController {
            
            @IBOutlet weak var textLabel: UILabel!
            @IBOutlet weak var progressView: UIProgressView!
            
            var timer = Timer();
            let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720];
            var totalTime = 0;
            var secondPassed = 0;
            
            @IBAction func eggClicked(_ sender: UIButton) {
                textLabel.text = "How do you like your eggs?";
                timer.invalidate();
                let hardness = sender.currentTitle!
                totalTime = eggTimes[hardness]!
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
            }
            
            @objc func updateTimer(){
                if secondPassed < totalTime {
                    let percentageProgress = Float(secondPassed) / Float(totalTime);
                    progressView.setProgress(percentageProgress, animated: true);
                    secondPassed += 1;
                } else {
                    timer.invalidate();
                    textLabel.text = "done";
                }
            }
        }

- Timer Version4

        import UIKit
        import AVFoundation

        class ViewController: UIViewController {
            
            @IBOutlet weak var textLabel: UILabel!
            @IBOutlet weak var progressView: UIProgressView!
            
            let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720];
            var player : AVAudioPlayer!
            var timer = Timer();
            var totalTime = 0;
            var secondPassed = 0;
            
            @IBAction func eggClicked(_ sender: UIButton) {
                progressView.setProgress(0, animated: true);
                textLabel.text = "How do you like your eggs?";
                timer.invalidate();
                secondPassed = 0;
                totalTime = 0;
                let hardness = sender.currentTitle!
                totalTime = eggTimes[hardness]!
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true);
            }
            
            @objc func updateTimer(){
                if secondPassed < totalTime {
                    let percentageProgress = Float(secondPassed) / Float(totalTime);
                    progressView.setProgress(percentageProgress, animated: true);
                    secondPassed += 1;
                } else {
                    timer.invalidate();
                    textLabel.text = "done";
                    playSound();
                }
            }
            
            func playSound(){
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3");
                player = try! AVAudioPlayer(contentsOf: url!);
                player.play();
            }
            
        }

20.02.04

- Size `Classes` and `Orientation`
- Undestand `Constraints`
- Learn about `Alignment` and `Pinning`
- Use `Containers` for more fine grained control
- Learn about `StackViews` 

20.02.03

- 오늘은 각각의 이미지와 아이콘을 사이즈별로 구하는 방법을 배웠다.
https://appicon.co/

- Xcode의 간단한 interface를 익혔다.

- 이미지 asset 관련 코드

        import UIKit

        class ViewController: UIViewController {
            
            @IBOutlet weak var diceImageView1: UIImageView!
            @IBOutlet weak var diceImageView2: UIImageView!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                diceImageView1.image = #imageLiteral(resourceName: "DiceSix");
                diceImageView2.image = #imageLiteral(resourceName: "DiceFour");
                
                diceImageView1.alpha = 0.5;
                
            }


        }
