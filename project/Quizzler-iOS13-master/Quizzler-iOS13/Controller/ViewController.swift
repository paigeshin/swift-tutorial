import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var countLabel: UILabel!
    
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func optionButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
    
        if(userGotItRight){
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }

        countLabel.text = "score: \(quizBrain.count)"

        quizBrain.nextQuestion()
    
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestion()
        option1Button.setTitle(quizBrain.getAnswers()[0], for: .normal)
        option2Button.setTitle(quizBrain.getAnswers()[1], for: .normal)
        option3Button.setTitle(quizBrain.getAnswers()[2], for: .normal)

        option1Button.backgroundColor = UIColor.clear
        option2Button.backgroundColor = UIColor.clear
        option3Button.backgroundColor = UIColor.clear


        progressBar.setProgress(quizBrain.getProgressValue(), animated: true)

    }

}

