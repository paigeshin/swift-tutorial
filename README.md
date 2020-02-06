# swift-tutorial
회사서 급하게 iOS가 필요하다고 해서 시작한 스터디

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
