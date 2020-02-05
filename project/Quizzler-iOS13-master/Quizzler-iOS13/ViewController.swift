import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!

    let quiz = [
        ["Four + Two is equal to Six.", "True"],
        ["Five - Three is greater than One", "True"],
        ["Three + Eight is less than Ten", "False"]
    ];

    var questionNumber = 0;

    override func viewDidLoad() {
        super.viewDidLoad();
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        questionNumber += 1;
        updateUI();
    }

    func updateUI() {
        if (quiz.count > questionNumber) {
            questionLabel.text = quiz[questionNumber][0];
        }
    }
    
}

