import UIKit

class WelcomeViewController: UIViewController {

    let TAG: String = "WelcomeViewController"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTitle()
    }
    
    func animateTitle(){
        titleLabel.text = ""
        var charIndex:Double = 0
        let titleText = K.appTitle
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false, block: {(timer) in
                self.titleLabel.text?.append(letter)
            })
            charIndex += 1
        }
    }
    
}
