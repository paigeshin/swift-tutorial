import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!

    var quizBrain:QuizBrain = QuizBrain()
    var correctAnswer:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()

    }

    @IBAction func answerButtonClicked(_ sender: UIButton) {

        let userAnswer:String = sender.currentTitle!
        let result:Bool = quizBrain.decideAnswer(answer: userAnswer)

        if(result){
            correctAnswer += 1
        }

        scoreLabel.text = "score: \(quizBrain.getScore())"

        progressBar.setProgress(quizBrain.getProgressValue(), animated: true)
        quizBrain.nextQuestion()
        update()

    }

    func update() {

        let question = quizBrain.getQuestion()
        questionLabel.text = question.question
        answer1Button.setTitle(question.answer[0], for: .normal)
        answer2Button.setTitle(question.answer[1], for: .normal)
        answer3Button.setTitle(question.answer[2], for: .normal)

    }


}

